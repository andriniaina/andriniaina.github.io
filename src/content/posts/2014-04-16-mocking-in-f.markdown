---
layout: post
title: Mocking objects with F# and FsMocks
date: 2014-04-16
toc: false
images:
tags:
  - testing
  - EN
---

[FsMocks](https://github.com/andriniaina/FsMocks) is a wrapper around [Rhino.Mocks](http://ayende.com/wiki/Rhino+Mocks+Documentation.ashx) that simplifies [mocking](http://en.wikipedia.org/wiki/Mock_object) with F#. The API is simple and straightforward because it uses a human-friendly DSL syntax. It can be combined with other test frameworks (NUnit, xUnit, FsUnit, etc.).  
It is intended to be readable, simple to use, strong typed (and refactor-friendly):

```fsharp
o.Call(1) |> returns 1 |> only_if_argument [Is.NotNull()] |> expected at_least_once
```

Below, I show FsMocks' syntax, compared to traditional Rhino/Moq/C# mocks.

We suppose that we work with the [MyService class here](https://gist.github.com/andriniaina/10923310)

# Specifying mock behavior via simple declarative specifications



```fsharp
module myTests =
    open FsMocks.Syntax

    [<Xunit.Fact>]
    let ``When MyService Builds Int 9999, we should write "Wrote int: 9999" in the text writer`` () =
        use repo = new FsMockRepository()
        let writer:ITextWriter = repo.strict []

        repo.define Unordered {
            writer.WriteLine("Wrote int: 9999") |> returns true |> expected once
        }
        let service = new MyService(writer)
        service.BuildInt(9999)
```

That's it!! You can compare with the with the [equivalent C# code](https://gist.github.com/andriniaina/10933483)

* no ReplayAll()
* no VerifyAll() because it is always systematically called
* no unreadable method names and no `DisplayName` attribute parameters
* no clutered lambdas



Now, compare this [trivial test in C#](https://gist.github.com/andriniaina/10933673)
with this one in F# :

```fsharp
    let [<Fact>] ``1) 2 Ordered nested in 1 Unordered``() =
        use mock = new FsMockRepository()
        let list:int IList = mock.strict []
        mock.define Unordered {
            mock.define Ordered {
                list.Add(1) |> expected once
                list.Add(2) |> expected once
            }
            mock.define Ordered {
                list.Add(3) |> expected once
                list.Add(4) |> expected once
            }
        }
        list.Add(1)
        list.Add(2)
        list.Add(3)
        list.Add(4)
```


## Documentation
You can find more info on the [FsMocks](https://github.com/andriniaina/FsMocks) homepage.

