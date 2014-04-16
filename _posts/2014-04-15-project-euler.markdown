---
layout: post
categories: EN languages
title: Solving a problem with various languages
---

The idea of the following posts are to show the differences and strength of different languages (elegance, readability, conciseness).

I will try to use my best syntax for each language  but you will notice that I am most of time biased towards concise languages like F# or python :)

I will regularly update the post with different problems.

# Project Euler [problem 1](http://projecteuler.net/problem=1)
> If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23. 
>
> Find the sum of all the multiples of 3 or 5 below 1000.


F#
--------------
It's the most concise language I know.

```fsharp
let isMultipleOf n i = i % n = 0
let isMultipleOf3or5 i = isMultipleOf 3 i || isMultipleOf 5 i

seq {1..999}
	|> Seq.filter isMultipleOf3or5
	|> Seq.sum
```

So elegant!
Note that we could have defined curried versions of `isMultipleOf` by writing: `let isMultipleOf3 = isMultipleOf 3` 

Python
------------
```python
def isMultipleOf (n,i): return i % n == 0
def isMultipleOf3or5 (i): return isMultipleOf(3,i) || isMultipleOf(5,i)

sum(filter(isMultipleOf3or5, range(1, 1000)))
# range(1, 1000) does not include 1000. How odd.
```
Without F#'s `|>` operator that inverts the position of the argument and the function, and therefore lets you read from left to right, it's less natural in my opinion. But it's still readable.

C#
--------------
Still elegant thanks to Linq but so verbose... You can see why I prefer to use other .NET languages when I have the choice.

```csharp
static IEnumerable<int> numbersTo(int n)
{
	for (var i = 0; i < n; ++i )
		yield return i;
}
static bool isMultipleOf(int n, int i)
{
	return i % n == 0;
}

static void Main(string[] args)
{
	// using the simpler "functional" style instead of imperative code
	(
		from n in numbersTo(1000)
		where isMultipleOf(3, n) || isMultipleOf(5, n)
		select n
	)
	.Sum();
}
```

So; many; lines; of; code;

At least you don't have to write imperative-style code like in javascript:

javascript
-----------------
```javascript
function isMultipleOf(n,i) {
	return i%n==0;
}
var sum=0;
for(var i=1; i<1000; i++)
{
	if(isMultipleOf(3,i) || isMultipleOf(5,i))
	{
		sum += i;
	}
}
```

After having practiced F# these last years, I really miss the functional helpers like filter/map/reduce. Also, there seem to be so many ways to introduce bugs just because of the language:
(mutable `sum` variable,  manual imperative loops, weak typing, no compilation and therefore no type checking, ...)

I really like javascript but to be honest it's maybe the worst language for algorithms ([typescript](http://www.typescriptlang.org/) solves some of its problems)...
Even C++ seems better:

C++
------------

```c++
static bool isMultipleOf(int n, int i)
{
	return i%n == 0;
}

int _tmain(int argc, _TCHAR* argv[])
{
	int sum = 0;
	for (int i = 1; i<1000; i++)
	{
		if (isMultipleOf(3, i) || isMultipleOf(5, i))
		{
			sum += i;
		}
	}
}
```

Mandatory type declarations, imperative programming, no simple way to define sequences/enumerables, ...

Fortunately, it's compiled and statically typed

