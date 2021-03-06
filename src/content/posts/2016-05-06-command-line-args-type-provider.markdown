---
layout: post
title: Type provider for command-line arguments (WIP)
date: 2016-05-06
toc: false
images:
tags:
  - fsharp
  - cli
  - args
  - type provider
  - EN
---


Usage
----

```fsharp
// set all possible switches
// switches are all optional and unordered
type CustomArgsParser = Andri.TypeProviders.CliParametersParser<"-switch2 -a -b -c">

[<EntryPoint>]
let main args =
  let parsedArgs = CustomArgsParser(args)
  printfn "switch2: %s" (parsedArgs.switch2) // displays Option<string> = Some "11"
```

```
myApp.exe -switch2 11 -b
```

Source
----

```fsharp
namespace Andri

open System
open System.Reflection
open Microsoft.FSharp.Core.CompilerServices
open Microsoft.FSharp.Quotations
open Samples.FSharp.ProvidedTypes

module utils =
    let argsToDict (args:string list) =
        Seq.append args ([""])
            |> Seq.pairwise
            |> Seq.filter (fun (switchName, value) -> switchName.StartsWith("-"))
            |> Seq.map (fun (switchName, value) -> (switchName, if value.StartsWith("-") then "" else value))
            |> dict

[<TypeProvider>]
type SampleTypeProvider(config: TypeProviderConfig) as this =
    inherit TypeProviderForNamespaces()

    let namespaceName = "Samples.HelloWorldTypeProvider"
    let thisAssembly = Assembly.GetExecutingAssembly()
    let baseTy = typeof<obj>
    let regexTy = ProvidedTypeDefinition(thisAssembly, namespaceName, "CliParametersParser", Some baseTy)
    do
        regexTy.DefineStaticParameters(
            [ProvidedStaticParameter("params", typeof<string>)],
            (fun typeName parameterValues ->
                printfn "typeName=%s" typeName
                printfn "parameterValues.Length=%s" (Convert.ToString(parameterValues.Length))
                printfn "parameterValues=%s" (Convert.ToString(parameterValues.[0]))
                let ty = ProvidedTypeDefinition(
                            thisAssembly,
                            namespaceName,
                            typeName,
                            baseType = Some baseTy)

                let parameterValue = parameterValues.[0] :?> string
                let args = Seq.append (parameterValue.Split(' ')) ([""])
                let pairs = Seq.pairwise args |> Seq.filter (fun (switchName, value) -> switchName.StartsWith("-")) |> Seq.map (fun (switchName, value) -> (switchName, if value.StartsWith("-") then "" else value))
                pairs |> Seq.map (fun (p,t) -> ProvidedProperty(p.Replace("-",""), typeof<string option>,GetterCode = fun args ->
                    <@@
                        let d = (%%args.[0]:obj) :?> System.Collections.Generic.IDictionary<string,string>
                        if d.ContainsKey(p) then Some(d.[p]) else None
                    @@>)) |> Seq.iter (ty.AddMember)
                ty.AddMember (ProvidedConstructor(parameters = [ProvidedParameter("args", typeof<string list>)], InvokeCode = fun args -> <@@ utils. argsToDict (%%args.[0]:string list) @@>))
                ty
              ))
        this.AddNamespace(namespaceName, [regexTy])


[<assembly:TypeProviderAssembly>]
do()
```
