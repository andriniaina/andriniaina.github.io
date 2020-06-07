---
layout: post
title: F# as a testing tool
date: 2014-04-24
toc: false
images:
tags:
  - testing
  - EN
---

F# as a language has many features that makes writing test easier and faster compared to other .NET languages.
Most of the time, if I really have to write C# code (which I rarely do now), I usually end up writing the test cases with F# because its much more productive.

Test frameworks
=================

**[xUnit](https://github.com/xunit/xunit)** is the most adapted test framework because it accepts static classes/methods as test fixtures (F# modules are compiled as static classes). In the beginning, I found that the absence of `[TestFixture]`or `[TestClass]` was counterproductive but it is actually a good thing: it forces you to never use a context outside of the function and prevents problems caused by mutiple test threads concurrency.


Why F# is better than C# (at least for tests)
=================

## Write unit-testable code
F# is a functional language. Consequently, most functions in a well written code in F# is unit-testable out-of-the-box. Your code (well... most of it) should be stateless.

Because F# must be compatible with the .NET  CLI and runtime, it is not a pure functional language, so it's still possible to create an ugly stateful program with a lot of mutable variables (But thanks to the language syntax, you probably won't).

## Readable function names
Member names in F# accept any character (including punctuation and spaces). You don't need to add a test description anymore: your test method name fully describes what the test tries to validate.

```fsharp
module ``User visits the Homepage`` =
	let [<Fact>] ``Show list of Stories in rank order`` =
		raise (NotImplementedException())
```

The equivalent in [**C#**](https://gist.github.com/andriniaina/11304542#file-visithomepage-cs) takes 2x more lines with 

* code attributes that clutters the code
* LongFunctionNamesThatAreNotFriendly()

## Test specific languages (DSLs)
[FsTest](http://fstest.codeplex.com/) and [FsUnit](https://github.com/fsharp/fsunit) are wrappers around the popular tests frameworks (including xUnit) that let you write your assertions in a DSL specific to testing:

```fsharp
1 |> should equal 1
"foobar" |> should contain "foo"
```

## Mock specific languages
In the same way, [FsMocks](https://github.com/andriniaina/FsMocks) is a wrapper around Rhino.Mocks  (not threadsafe)

```fsharp
o.Call(1) |> returns 1 |> only_if_argument [Is.NotNull()] |> expected at_least_once
```

[Foq](https://foq.codeplex.com/) is a threadsafe mocking library for F#, but without the fancy DSL language.

## Create stubs on the fly
[F# Object Expressions](http://msdn.microsoft.com/en-us/library/dd233237.aspx) creates a new anonymous instance of an interface, without the need to declare a new class.

```fsharp
let myComparer = { new IComparer<_> with member x.Compare(l,r) = -1 }
```

## Interactive testing
If your code is well written (i.e. without complicated dependecies or unnecessary injections), you can test and prototype directly your program in Visual Studio with the interactive F# interpreter.

## Test without writing any test case
Well... not really but almost. [FsCheck](https://github.com/fsharp/FsCheck) is a tool for testing .NET programs automatically.

> The programmer provides a specification of the program, in the form of properties which functions, methods or objects should satisfy, and FsCheck then tests that the properties hold in a large number of randomly generated cases.

Read the [documentation](https://github.com/fsharp/FsCheck/blob/master/Docs/Documentation.md) to understand how powerful it is for some test cases.

## Behaviour Driven Development
[TickSpec](http://tickspec.codeplex.com/) is a lightweight framework with its own Gherkin interpreter.
Combined with the power of F# and backticks, it simplifies the steps implementation:

```
Scenario 1: Refunded items should be returned to stock
	Given a customer buys a black jumper
	And I have 3 black jumpers left in stock 
	When he returns the jumper for a refund 
	Then I should have 4 black jumpers in stock 
```

```fsharp
// a step definition
let [<Given>] ``I have (.*) black jumpers left in stock`` (n:int) =  
    stockItem <- { stockItem with Count = n }
```

Phil describes on [his blog](http://trelford.com/blog/post/FunkyBDD.aspx) how to make it simpler (if your team has only programmers (who understand F#)), in a more functional manner -- without mutable state variables.

```fsharp
let performStep (calc:Calculator) (step,line:LineSource) =
    match step with
    | Given "I have entered (.*) into the calculator" [Int n] ->
        calc.Push n                        
```




