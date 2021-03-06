---
layout: post
title: Combine/Permutate a list of list in F#
date: 2015-11-27
toc: false
images:
tags:
  - fsharp
  - combinators
  - EN
---

Problem
===

Given the following data :

```fs
[
	["1";"2"];
	[];
	["5";"6";"7"]
]
```

Find all possible combinations.

Solution
=====

```fs
let rec _combine (acc:'T list) (ll: 'T list list) : 'T list list =
    match ll with
    | [] ->  [acc]
    | heads :: rest ->
        match heads with
        | [] -> _combine (null::acc) (rest)
        | _ ->  heads |> List.collect (fun h -> _combine (h :: acc) (rest))

let combine (ll:'T list list) : 'T list list =
    _combine [] ll
        |> List.map (List.rev)

let combineCsharpCompliant (ll:'T IList IList) =
	ll |> Seq.map (List.ofSeq) |> List.ofSeq |> combine |> List.map (System.Linq.Enumerable.ToList) |> System.Linq.Enumerable.ToList

let ll = [["1";"2"];[];["5";"6";"7"]]
combine ll
/// val it : string list list =
///    [["1"; null; "5"]; ["1"; null; "6"]; ["1"; null; "7"]; ["2"; null; "5"];
///       ["2"; null; "6"]; ["2"; null; "7"]]
```
