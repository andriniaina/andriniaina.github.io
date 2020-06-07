---
layout: post
title: CSV output formatter for WCF Data Services
date: 2015-11-09
toc: false
images:
tags:
  - wcf
  - odata
  - csv
  - EN
---

The [OData URL conventions](http://docs.oasis-open.org/odata/odata/v4.0/errata02/os/complete/part2-url-conventions/odata-v4.0-errata02-os-part2-url-conventions-complete.html#_Toc406398169) says that one can specify the media type of the response in the query, using the query parameter `$format`.
The requested media type can also be negociated through http content-type headers.
However, Microsoft included only the default Atom formatter in their implementation (WCF Data Services). A Json formatter can be included with a quick workaround).

With the code below, you can query a **OData WCF Data Service** and receive a **csv** file in the response.



Usage
------

Just add the attribute `[CsvSupportBehavior]` to your service class and add  the parameter `$format=txt` in the URL.

You can customize the output with `$format=txt:[separator?]:[csvHeader?]` (e.g.  `$format=txt:,:colHeader1,col2,col3` )

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

Code
----
> clone from gist.github : [https://gist.github.com/andriniaina/01fb854e449376c75185]( https://gist.github.com/andriniaina/01fb854e449376c75185)

```csharp
//-----------------------------------------------------------------------
// http://andriniaina.github.io
//-----------------------------------------------------------------------
namespace WCFDataServiceFormatExtensions
{
    using System;
    using System.Collections.Generic;
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
                UriTemplateMatch match = (UriTemplateMatch)request.Properties["UriTemplateMatchResults"];
                string format = match.QueryParameters["$format"];
                string selectors = match.QueryParameters["$select"];

                if (format != null && format.StartsWith("txt", StringComparison.InvariantCultureIgnoreCase))
                {
                    /*
                    string customheader = match.QueryParameters["$customCsvHeader"];
                    if (customheader != null)
                    {
                        match.QueryParameters.Remove("$customCsvHeader");
                    }
                    */
                    ////check if separator found 
                    var spec = format.Split(':');
                    var separator = spec.Length > 1 ? spec[1] : "\t";
                    var header = spec.Length > 2 ? spec[2] : "";

                    match.QueryParameters.Remove("$format");
                    token = string.Format("{0}¤separator={1}¤selectors={2}¤header={3}", requestType, separator, selectors, header);
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
                            var stateDic = ((string)correlationState).Split('¤').Select(x => x.Split(new[] { '=' }, 2)).ToDictionary(x => x[0], x => x[1]);

                            using (var bodyReader = reply.GetReaderAtBodyContents())
                            {
                                bodyReader.ReadStartElement();
                                var txt = Encoding.UTF8.GetString(bodyReader.ReadContentAsBase64());
                                var separator = stateDic["separator"];
                                var selectors = stateDic["selectors"].Split(',').Select(x => x.Trim()).Select(getXPath).ToList();

                                var csvHeaders = string.IsNullOrWhiteSpace(stateDic["header"]) ?
                                    string.Join(separator, stateDic["selectors"].Split(',').Select(s => s.Split('/').Last())) 
                                    :
                                    stateDic["header"];

                                using (var reader = new StringReader(txt))
                                {
                                    var doc = new System.Xml.XmlDocument();
                                    doc.Load(reader);
                                    var nsmgr = new XmlNamespaceManager(doc.NameTable);
                                    nsmgr.AddNamespace("base", "http://localhost:8080/WcfDataService1.svc/");
                                    nsmgr.AddNamespace("d", "http://schemas.microsoft.com/ado/2007/08/dataservices");
                                    nsmgr.AddNamespace("m", "http://schemas.microsoft.com/ado/2007/08/dataservices/metadata");
                                    nsmgr.AddNamespace("atom", doc.DocumentElement.NamespaceURI);
                                    var n = doc.DocumentElement.SelectNodes("/atom:feed", nsmgr);

                                    var csv = new StringBuilder();
                                    var lines = new List<string>();
                                    foreach (XmlNode entry in doc.DocumentElement.SelectNodes("/atom:feed/atom:entry", nsmgr))
                                    {
                                        var grapes = selectors.Select(x => entry.SelectNodes(x, nsmgr).Cast<XmlNode>().ToList()).Cast<IList<XmlNode>>().ToList();
                                        var innerJoinedLines = Utils.x.combineClrCompliant(grapes).Select(x => string.Join(separator, x.Select(node => node.InnerText))).ToList();
                                        lines.AddRange(innerJoinedLines);
                                    }

                                    var csvContent = string.Join("\r\n", new[] { csvHeaders }.Concat( lines));
                                    Encoding encoding = GetReplyEncoding(response);
                                    Message newreply = Message.CreateMessage(MessageVersion.None, string.Empty, new CustomBinaryWriter(csvContent, encoding));
                                    newreply.Properties.CopyProperties(reply.Properties);
                                    
                                    var continuationUrl = doc.SelectSingleNode("/atom:feed/atom:link[@rel='next']/@href", nsmgr);
                                    if (continuationUrl != null)
                                    {
                                        var httpmsg = (HttpResponseMessageProperty)reply.Properties[System.ServiceModel.Channels.HttpResponseMessageProperty.Name];
                                        httpmsg.Headers.Add("Continuation-Url", continuationUrl.Value);
                                    }
                                    reply = newreply;
                                }
                            }
                        }
                    }
                }
            }
        }

        private string getXPath(string selector)
        {
            var parts = selector.Split('/');
            if (parts.Length == 1)
            {
                return string.Format("atom:content/m:properties/d:{0}", parts[0]);
            }
            else
            {
                var xpath1 = new StringBuilder();
                xpath1.AppendFormat("atom:link[@title='{0}']", parts[0]);
                for (int i = 1; i < parts.Length - 1; i++)
                {
                    xpath1.AppendFormat("/m:inline/atom:entry/atom:link[@title='{0}']", parts[i]);
                }
                xpath1.AppendFormat("/m:inline/atom:entry/atom:content/m:properties/d:{0}", parts.Last());


                var xpath2 = new StringBuilder();
                xpath2.AppendFormat("atom:link[@title='{0}']", parts[0]);
                for (int i = 1; i < parts.Length - 1; i++)
                {
                    xpath2.AppendFormat("/m:inline/atom:feed/atom:entry/atom:link[@title='{0}']", parts[i]);
                }
                xpath2.AppendFormat("/m:inline/atom:feed/atom:entry/atom:content/m:properties/d:{0}", parts.Last());
                return xpath1 + "|" + xpath2;
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
