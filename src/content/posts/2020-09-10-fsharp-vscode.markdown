---
title: "Data Science in F#5/.NET with VsCode"
date: 2020-09-10T17:11:18+02:00
draft: false
---

When thinking of data science or machine learning, Python immediately come to mind. No other production-ready programming language can match its extensive set of libraries (pandas, numpy, scikit, etc.) paired with proven experimentation tools (jupyter, dash plotly, etc.).

Other ecosystems are trying to catch up in terms of libraries but, when it comes to producing analysis and insight in a short timeframe, almost none have the tooling that still makes python the champion of productivity.

On the other hand, there is one field where python is lagging compared to other languages: performance. Even though most of the supporting libraries for data science and machine learning in python are written in native languages, [python will never have the same performance as pure native code](https://benchmarksgame-team.pages.debian.net/benchmarksgame/fastest/python3-gcc.html).
In a world where milliseconds (or even microseconds in some fields) matter to deliver information, some data science projects have to go through the following steps:

1. Data scientists write a Proof Of Concept in python/jupyter.
2. When going to production:
  * -either- Software Engineers re-translate the logic to another language
  * -or- Data Scientists have to expose the logic as a micro-service (and therefore need knowledge in api authoring)

Thankfully, .NET now brings the best of both worlds:

* Safety: by default, the code runs in a sandbox
* Productive languages: the .NET ecosystem supports [dozens of languages that you can choose from](https://en.wikipedia.org/wiki/Category:.NET_programming_languages) (including python!) that can talk with each other
* High performance: [C# has almost the same performance as native C++](https://benchmarksgame-team.pages.debian.net/benchmarksgame/fastest/csharpcore-gpp.html)
* An [extensive set of libraries](https://fsharp.org/guides/data-science/#integrated-packages) including dataframes, bindings to numpy and tensorflow, and charting libraries.
* A [jupyter-like interactive notebook for F#](https://marketplace.visualstudio.com/items?itemName=andriniaina.fsharp-interactive-datascience) with support for charts and custom formatters

In this article I will show you how to install and use the interactive console notebook for F#. I will discuss the technical implementations like performance and libraries in other future articles.

Installing the F# notebook for VsCode
==

1. Install .NET Core 5: The extension uses F#5 syntax and therefore is only compatible with dotnet core 5.
2. Install the [F# notebook extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=andriniaina.fsharp-interactive-datascience) itself
3. Locate where extension is installed (you will need this path in the next step):
    * **Windows** ```%USERPROFILE%\.vscode\extensions\andriniaina.fsharp-interactive-datascience-*```
    * **macOS** ```~/.vscode/extensions/andriniaina.fsharp-interactive-datascience-*```
    * **Linux** ```~/.vscode/extensions/andriniaina.fsharp-interactive-datascience-*```

How to use
===
The extension works exactly like the interactive fsharp interpreter (FSI) but with an additional panel that displays formatted data.
When one of the `Notebook.*` helpers are called, a cell will be added to the panel.

In order to get play with a notebook:
1. Edit VSCode ```settings.json``` in the workspace folder:
    ```json
    {
        "FSharp.fsiExtraParameters": [
            "--langversion:preview",
            "--load:path/to/extension/scripts/Notebook.fsx" // change this path
        ]
    }
    ```
2. open the notebook panel with the command Ctrl+Alt+P > "**F# Notebook+DataScience: Open Panel**"
3. open an *.fsx file and start coding!

> Tip: Alt+Enter will execute the current line

![demo](https://github.com/andriniaina/fsharp-interactive-datascience/raw/master/demo.gif)


Simple examples
===
The extension has multiple built-in formatters.

Primitives
--
```fsharp
// Ctrl+Alt+P : F# Notebook: Open Panel
Notebook.Text (1+1)
Notebook.Text "Hello world"
```

![screenshot](/img/fsharp-notebook/1.png)

Markdown
---
```fsharp
// Ctrl+Alt+P : F# Notebook: Open Panel
Notebook.Markdown """
# Hello, Markdown!
"""
```

Charts
---

```fsharp
// Ctrl+Alt+P : F# Notebook: Open Panel
let chart =
    Chart.Line
        [ 1, 1
          2, 2 ]
    |> Chart.WithWidth 400
    |> Chart.WithHeight 300
    |> Chart.WithLayout(Layout(title = "ok", margin = margin))
Notebook.Plotly chart
```
![screenshot](/img/fsharp-notebook/4.png)


Maps
---
```fsharp
// Ctrl+Alt+P : F# Notebook: Open Panel
let marginWidth = 50.0
let margin = Margin(l = marginWidth, r = marginWidth, t = marginWidth, b = marginWidth)
type AlcoholConsumption = CsvProvider<"https://raw.githubusercontent.com/plotly/datasets/master/2010_alcohol_consumption_by_country.csv">
let consumption = AlcoholConsumption.Load("https://raw.githubusercontent.com/plotly/datasets/master/2010_alcohol_consumption_by_country.csv")
let locations = consumption.Rows |> Seq.map (fun r -> r.Location)
let z = consumption.Rows |> Seq.map (fun r -> r.Alcohol)
let map =
    Chart.Plot([ Choropleth(locations = locations, locationmode = "country names", z = z, autocolorscale = true) ])
    |> Chart.WithLayout(Layout(title = "Alcohol consumption", width = 700.0, margin = margin, geo = Geo(projection = Projection(``type`` = "mercator"))))

// display chart
Notebook.Plotly map
```

![screenshot](/img/fsharp-notebook/2.png)

Dataframes
---
(beta)

```fsharp
// Ctrl+Alt+P : F# Notebook: Open Panel
#r "nuget: Microsoft.Data.Analysis"
open Microsoft.Data.Analysis
let locations, alcohol =
    consumption.Rows
        |> Seq.map (fun row -> row.Location, row.Alcohol)
        |> List.ofSeq
        |> List.unzip
let df = new DataFrame(
    new StringDataFrameColumn("location", locations),
    new PrimitiveDataFrameColumn<decimal>("consumption", alcohol)
)
Notebook.DataFrame df

```
![screenshot](/img/fsharp-notebook/3.png)


Custom printers
===
You can also add your own formatters that will display the data in your customized format.

```fsharp
open Notebook
fsi.AddPrinter(fun (data : YourType) ->
    ... // Format to string
    |> HTML // or SVG or Markdown or Text
    |> printerNotebook
)

let x = new YourType() // this will automatically print x in the notebook panel
```

Conclusion
===
This extension is not the only one that offers an interactive environment for F#. There are other projects that offer a similar functionality, notably the jupyter kernel for C#/F#.

But none of these projects offer the same ease of installation and level of integration with Visual Studio code (code completion, code lenses, integration with other F# extensions for formatting or code quality etc.).

That’s all from this article. In the next article, I will do a quick round on machine learning with F#.

If you have any questions or just want to chat with me feel free to leave a comment below or contact me on social media.
