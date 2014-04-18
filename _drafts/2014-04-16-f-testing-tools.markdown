---
layout: post
categories: EN test
title: F# as a testing tool
---

F# as a language has many features that makes writing test easier and faster compared to other .NET languages.
Most of the time, if I really have to write C# code (which I rarely do now), I usually end up writing the test cases with F#.

# Testing frameworks
* **[xUnit](https://github.com/xunit/xunit)** is the most adapted test framework because it accepts static classes/methods as test fixtures (F# modules are compiled as static classes). In the beginning, I found that the absence of `[TestFixture]`or `[TestClass]` was counterproductive but it is actually a good thing: it forces you to never use a context outside of the function and prevents problems caused by mutiple test threads concurrency.

* **Function names**: Member names accept any character in F#. You don't need to add a test description anymore : your test method name should fully describe what the test tries to validate.




