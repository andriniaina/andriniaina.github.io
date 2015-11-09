---
layout: post
categories: EN wcf odata
title: CSV output formatter for WCF Data Services
---



<script src="https://gist.github.com/andriniaina/01fb854e449376c75185.js"></script>


```csharp
//-----------------------------------------------------------------------
// http://andriniaina.github.io
//-----------------------------------------------------------------------
namespace WCFDataServiceFormatExtensions
{
    using System;
    using System.IO;
    using System.Linq;
    using System.ServiceModel;
    using System.ServiceModel.Channels;
    using System.ServiceModel.Description;
    using System.ServiceModel.Dispatcher;
    using System.Text;
    using System.Xml;
    using System.Xml.Linq;


    /// <summary>
    /// This Class provide an attribute that need to be applied on data service class in order to enable text output
    /// </summary>
    [AttributeUsage(AttributeTargets.Class)]
    public class CsvSupportBehaviorAttribute : Attribute, IServiceBehavior
    {
        /// <summary>
        /// Provides the ability to pass custom data to binding elements to support the contract implementation.
        /// </summary>
        /// <param name="serviceDescription">The service description of the service.</param>
        /// <param name="serviceHostBase">The host of the service.</param>
        /// <param name="endpoints">The service endpoints.</param>
        /// <param name="bindingParameters">Custom objects to which binding elements have access.</param>
        void IServiceBehavior.AddBindingParameters(ServiceDescription serviceDescription, ServiceHostBase serviceHostBase, System.Collections.ObjectModel.Collection<ServiceEndpoint> endpoints, BindingParameterCollection bindingParameters)
        {
        }

        /// <summary>
        /// Provides the ability to change run-time property values or insert custom extension objects such as error handlers, message or parameter interceptors, security extensions, and other custom extension objects.
        /// </summary>
        /// <param name="serviceDescription">The service description.</param>
        /// <param name="serviceHostBase">The host that is currently being built.</param>
        void IServiceBehavior.ApplyDispatchBehavior(ServiceDescription serviceDescription, ServiceHostBase serviceHostBase)
        {
            foreach (ChannelDispatcher cd in serviceHostBase.ChannelDispatchers)
            {
                foreach (EndpointDispatcher ed in cd.Endpoints)
                {
                    ed.DispatchRuntime.MessageInspectors.Add(new CsvDataServiceFormatInspector());
                }
            }
        }

        /// <summary>
        /// Provides the ability to inspect the service host and the service description to confirm that the service can run successfully.
        /// </summary>
        /// <param name="serviceDescription">The service description.</param>
        /// <param name="serviceHostBase">The service host that is currently being constructed.</param>
        void IServiceBehavior.Validate(ServiceDescription serviceDescription, ServiceHostBase serviceHostBase)
        {
        }
    }

    /// <summary>
    /// Inspect incoming outgoing message and transform them in text version if required.
    /// </summary>
    public class CsvDataServiceFormatInspector : IDispatchMessageInspector
    {
        /// <summary>
        /// This is invoked automatically by data service calls.
        /// </summary>
        /// <param name="request">Incoming request message.</param>
        /// <param name="channel">Request channel</param>
        /// <param name="instanceContext">Operation Context for this instance.</param>
        /// <returns>Returns null.</returns>
        public object AfterReceiveRequest(ref Message request, IClientChannel channel, InstanceContext instanceContext)
        {
            object token = null;
            if (request.Properties.ContainsKey("UriTemplateMatchResults"))
            {
                string requestType = "RequestType=TXT";
                var separator = "\t";

                UriTemplateMatch match = (UriTemplateMatch)request.Properties["UriTemplateMatchResults"];
                string format = match.QueryParameters["$format"];

                if (format != null && format.StartsWith("txt", StringComparison.InvariantCultureIgnoreCase))
                {
                    ////check if separator found
                    int saperatorPos = format.IndexOf(':');
                    if (saperatorPos > 0)
                    {
                        separator = format.Substring(saperatorPos + 1);
                    }

                    match.QueryParameters.Remove("$format");
                    token = string.Format("{0};separator={1}", requestType, separator);
                }
            }

            return token;
        }

        /// <summary>
        /// This is invoked automatically by data service calls.
        /// </summary>
        /// <param name="reply">Actual responce from service.</param>
        /// <param name="correlationState">Correlation token returned in “AfterRequestReceived ”function.</param>
        public void BeforeSendReply(ref Message reply, object correlationState)
        {
            string requestType = "RequestType=TXT";

            HttpResponseMessageProperty response = reply.Properties[HttpResponseMessageProperty.Name] as HttpResponseMessageProperty;

            if (correlationState != null && correlationState is string)
            {
                if (response != null)
                {
                    string contentType = response.Headers["Content-Type"];
                    if (contentType != null)
                    {
                        bool isRequestTypeTXT = ((string)correlationState).ToLower().StartsWith(requestType.ToLower());
                        if (isRequestTypeTXT && contentType.StartsWith("application/atom", StringComparison.InvariantCultureIgnoreCase))
                        {
                            response.Headers["Content-Type"] = "text/csv;charset=utf-8";
                            var stateDic = ((string)correlationState).Split(';').Select(x => x.Split(new[] { '=' }, 2)).ToDictionary(x => x[0], x => x[1]);

                            using (var bodyReader = reply.GetReaderAtBodyContents())
                            {
                                bodyReader.ReadStartElement();
                                var txt = Encoding.UTF8.GetString(bodyReader.ReadContentAsBase64());
                                var separator = stateDic["separator"];
                                using (var reader = new StringReader(txt))
                                {
                                    var doc = XDocument.Load(reader);
                                    var atom = XNamespace.Get("http://www.w3.org/2005/Atom");
                                    var m = XNamespace.Get("http://schemas.microsoft.com/ado/2007/08/dataservices/metadata");
                                    var firstEntryProps = doc.Descendants(atom + "entry").Descendants(m + "properties").FirstOrDefault();
                                    var csvHeaders = (firstEntryProps != null) ? string.Join(separator, firstEntryProps.Elements().Select(x => x.Name.LocalName)) : "";

                                    var lines = from p in doc.Descendants(atom + "entry").Descendants(m + "properties")
                                                select string.Join(separator, p.Descendants().Select(x => x.Value));

                                    var content = string.Join("\n", new[] { csvHeaders }.Concat(lines));
                                    Encoding encoding = GetReplyEncoding(response);
                                    Message newreply = Message.CreateMessage(MessageVersion.None, string.Empty, new CustomBinaryWriter(content, encoding));
                                    newreply.Properties.CopyProperties(reply.Properties);

                                    var continuationUrl = doc.Elements(atom + "feed").Elements(atom + "link").Where(x => (string)x.Attribute("rel") == "next").Select(x => (string)x.Attribute("href")).FirstOrDefault();
                                    if (continuationUrl != null)
                                    {
                                        var httpmsg = (HttpResponseMessageProperty)reply.Properties[System.ServiceModel.Channels.HttpResponseMessageProperty.Name];
                                        httpmsg.Headers.Add("Continuation-Url", continuationUrl);
                                    }
                                    reply = newreply;
                                }
                            }
                        }
                    }
                }
            }
        }

        Encoding GetReplyEncoding(HttpResponseMessageProperty response)
        {
            Encoding encoding = Encoding.UTF8;
            string charset = response.Headers["Content-Type"];
            int loc = charset.IndexOf("charset", StringComparison.InvariantCultureIgnoreCase);
            if (loc > 0)
            {
                charset = charset.Substring(loc, charset.Length - loc);
                loc = charset.IndexOf("=");
                charset = charset.Substring(charset.IndexOf("=") + 1, charset.Length - loc - 1);
                if (charset.IndexOf(";") > 0)
                {
                    loc = charset.IndexOf(";");
                    charset = charset.Substring(charset.IndexOf(";") + 1, charset.Length - loc - 1);
                }

                encoding = Encoding.GetEncoding(charset);
            }

            return encoding;
        }
    }

    /// <summary>
    /// Custom binary writer class for writing WCF binary messages body.
    /// </summary>
    class CustomBinaryWriter : BodyWriter
    {
        /// <summary>
        /// Content to write.
        /// </summary>
        private string content;

        /// <summary>
        /// Initializes a new instance of the CustomBinaryWriter class.
        /// </summary>
        /// <param name="content">Content to write</param>
        public CustomBinaryWriter(string content, Encoding encoding)
            : base(false)
        {
            this.content = content;
            this.encoding = encoding;
        }

        Encoding encoding;
        /// <summary>
        /// Called by service implementatio.
        /// </summary>
        /// <param name="writer">XmlDictionaryWriter instance provided by service.</param>
        protected override void OnWriteBodyContents(XmlDictionaryWriter writer)
        {
            writer.WriteStartElement("Binary");
            byte[] buffer = this.encoding.GetBytes(this.content);
            writer.WriteBase64(buffer, 0, buffer.Length);
            writer.WriteEndElement();
        }
    }
}

```


Usage
------

```csharp
namespace SampleDataService
{
    [CsvSupportBehavior]
    public class WcfDataService1 : DataService< sampleEntities >
    {
        public static void InitializeService(DataServiceConfiguration config)
        {
          config.SetEntitySetAccessRule("*", EntitySetRights.AllRead);
          config.SetEntitySetPageSize("*", 10);
          config.DataServiceBehavior.MaxProtocolVersion = DataServiceProtocolVersion.V3;
        }
    }
}
```
