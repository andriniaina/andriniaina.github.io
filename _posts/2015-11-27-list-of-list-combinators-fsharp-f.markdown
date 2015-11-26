---
layout: post
categories: EN fsharp F# combinators
title: Combine/Permutate a list of list in F#
---

Given the following data :
```fsharp
[
	["1";"2"];
	[];
	["5";"6";"7"]
]
```

Find all possible combinations

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

let ll = [["1";"2"];[];["5";"6";"7"]]
combine ll
/// val it : string list list =
///    [["1"; null; "5"]; ["1"; null; "6"]; ["1"; null; "7"]; ["2"; null; "5"];
///       ["2"; null; "6"]; ["2"; null; "7"]]
```
