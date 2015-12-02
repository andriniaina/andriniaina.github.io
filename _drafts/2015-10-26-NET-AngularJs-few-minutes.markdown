---
layout: post
categories: EN test
title: Creating a .NET/AngularJs website in under 30 minutes
---

This post assumes that you have an existing legacy application with a working database and you want to migrate to AngularJs.


Create a new asp.NET project
----------------------------
File > New > Project > ASP.NET Web Application

Pick any template. MVC, old Web Forms, or even an empty website.

> Easy. 30 seconds.


Create the Entities Framework data model
----------------------------

Using the Visual Studio templates, create a new Entity Data model.
The fastest way to do that is by generating a database-first \*.edmx file from your existing legacy database.

> Easy, 4 min.


Create the REST service
----------------------------
The fastest way to expose existing data with Json using  .NET is by creating a (WCF Data Service)[https://msdn.microsoft.com/en-us/library/cc668792(v=vs.110).aspx].
You can skip the microsoft documentation but make sure to read the (Getting Started page from OData.org)[http://www.odata.org/getting-started/].

OData is "an **open protocol** to allow the creation and consumption of **queryable** and **interoperable RESTful APIs** in a **simple** and **standard** way"

By using the API provided by Microsoft, you can easily expose any dataset on the internet, using standard REST URLs, with simple pre-programmed CRUD (Create, Read, Update, Delete) operations.

Now, create your OData class. It must inherits the DataService<T> generic class, where T is the class of the Entity Framework context you want to expose.

> 10min
