% Functional Programming
% Andri Rakotomalala
% March 25, 2015

# Fonction pure

## Definition

Soit une fonction $f : x \longmapsto y$,

<br/><br/>
$f$ est **pure** si: pour une valeur $x$ donnée, on aura **toujours** la même valeur $y$.

## Exemple


Exemple de fonction(s) **impure**:
```java
var bl = new BusinessLayer();
try {
	bl.readFromFile("/tmp/file");
	var filters = getFilters("file.config");
	if(bl.validateData()) {	// !
		bl.filterData(filters);	// !
		return bl.filteredData; // !!
	}
}
catch(Exception) {	// !
	logSomething(); throw;
}
```

<p class="fragment roll-in">
Exemple de fonction(s) **pure**:

```java
var content = read("/tmp/file"); // pure?
var filters = getFilters("file.config"); // pure?
var data = fromString(content); // pure
var validatedData = validateData(data); // pure
return filteredData = filterData(filters, validatedData); // pure
```

</p>

## -

Un algorithme fonctionnel doit pouvoir s'écrire avec un enchaînement de fonctions pures:

<p class="fragment roll-in">
```java
return filterData(getFilters("file.config"), validateData(fromString(read("/tmp/file"))));
```
</p>



## Conclusion: Propriétés d'une fonction pure

**Pourquoi la programmation fonctionnelle peut vous aider à écrire de meilleures librairies**:

* Optimisations:
  * Un compilateur peut **réordonner ou paralléliser** deux fonctions pures, sans impact sur le résultat de l'execution
  * **Lazy evaluation**: un compilateur peut ignorer une instruction si elle n'est jamais utilisée
  * Le résultat d'une fonction peut être connue à l'avance sans avoir à la ré-executer une 2è fois(**Memoization**).

* Facile à maintenir:
  * Pas de side effect => Comportement prévisible
  * Pas d'état intermédiaire, pas de "variable" (**immutabilité**) => lecture du code facilitée
  * pas de partage de données => **threadsafe**, sans avoir à manipuler de mutex, lock, sémaphore, etc.
  * aucun contexte/state => directement **testable unitairement** sans avoir recours à des Mocks, Stubs, héritages, etc.



Introduction à F#
====

## Bases
```fsharp
// **tout** est fonction
let a = 1
// soit a = 1
// var a = 1
```  

```fsharp
// une fonction qui ne prend aucun paramètre est une "valeur"
let b =
	Console.WriteLine("coucou")
	1 // la dernière ligne est la valeur de retour
	// un bloc de code est indenté
```  

```fsharp
// on peut passer en paramètre et retourner l'ensemble vide "()" unit
let ecrireConsole () =
	Console.WriteLine "coucou"
	() // retourner la valeur "unit" (~void)
```

```fsharp
// les parenthèses sont optionnels: les paramètres sont séparés par des espaces
let ecrireConsole () texte1 () () () texte2 = //  6 paramètres
	Console.WriteLine texte1
	Console.WriteLine texte2
// type inference: les paramètres texte1 et texte2 sont des string; il n'est souvent pas nécessaire de noter le type d'une valeur

let ecrireConsole (texte1:string) (texte2:string) : unit =
	// do something
```

```fsharp
// un tuple est une seule valeur
let ecrireConsole texte1 (texte2, texte3)=
	Console.WriteLine (texte1 + texte2 + texte3)
// est équivalent à:
let ecrireConsole texte1 param2_3 =
	let texte2, texte3 = param2_3
	Console.WriteLine (texte1 + texte2 + texte3)
```

```fsharp
// on peut passer des fonctions en paramètre:
let ecrire writeStrategy texte1 =
	writeStrategy texte1

ecrire (Console.WriteLine) "coucou"
```

```fsharp
// currying
let ecrire writeStrategy texte1 =
	writeStrategy texte1
	texte1
let consoleWriteStrategy = Console.WriteLine
let ecrireDansConsole = ecrire consoleWriteStrategy
ecrireDansConsole "coucou"
```

```fsharp
// opérateur triangle (notation inversée)
"coucou" |> ecrireDansConsole
"coucou" |> ecrireDansConsole |> ecrireDansFichier |> ecrireRemoteProcedureCall |> ignore
```

```fsharp
// composition de fonctions
let f x = x**2.1
let g x = x+1.0
let h = g >> f // let h x = (x+1.0)**2.1
```

# OO designs patterns

## Singleton

```fsharp
let instance = new MaClasse()
```

## Factory

```fsharp
let afficherCaracteristiques (phoneFactory:unit->ITelephone) =
    let phone = phoneFactory ()
    printfn "name=%s, price=%f" phone.Name phone.Price
```

## Abstract factory

```fsharp
let afficherCaracteristiques (phoneFactory:unit->ITelephone) =
    let phone = phoneFactory ()
    printfn "name=%s, price=%f" phone.Name phone.Price
```

<img src="http://upload.wikimedia.org/wikipedia/commons/9/9d/Abstract_factory_UML.svg?download" />


# Conclusion

## 

> the problem with object-oriented languages is they’ve got all this implicit environment that they carry around with them. You wanted a banana but what you got was a gorilla holding the banana and the entire jungle.
