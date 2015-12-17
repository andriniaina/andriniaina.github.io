---
layout: post
categories: EN javascript ecmascript
title: Javascript (ECMAScript) in 30 minutes
---

# Simple values

```javascript
155
10.23
true
false
'test'
"test"
null
undefined
NaN // 0/0 Not a Number
Infinity // 1/0
// array declaration
[1,2,3,4]
// anonymous object declaration with properties firstName and surname
{firstName:'John', surname:'Doe'}
```

# Basic syntax

```javascript
doStuff(); // Statements **can** be terminated by ;
doStuff() // or not...

// variable declaration
var a = 1;
var a=1, b=2, c=3; // multiple declarations

// a variable can be initialized without a declaration!!
b = 2;
// but one cannot use a variable unless it has been declared
f(x) // raises error "'x' is undefined"

// variables are not typed and can be redefined again in the same block
var a = 'foo'; var a = 'bar';  // no problem!!

// 'window' is the global scope variable
window.a // is 'foo'

// function declaration
function myFunction(a,b,c,d) {
  return 0;
}
// anonymous function declaration
function(a,b,c,d) {
  return 0;
}
// call function
myFunction('a', 1, 2, 'b');

// arguments are not checked
myFunction();  // equivalent to myFunction(undefined, undefined, undefined, undefined)

// arrays
var a = [];
a.push('foo');
a['key'] = 'value';

// Operators
1/8
1+2
1<2
'a'+'b' // == 'ab'
'a'<'b' // true
'a'=="a" // true
!false // true
```




# Implicit casts
```javascript
'a' + 1 // =='a1'
'he' + ['ll', 'o', 'world', '!'] // "hell,o,world,!"

// all the following statements are true
1=="1"
1==true
0==false
''==false // however: 'not empty'!=true
'not empty'!=false
undefined==false
!false
!undefined
!null
!0
!''


// which lets us write:
var a = '', b=null, c = 'not empty';
if(a || b) { // false
  // this block is never called
} else {
  if(c) { // c is 'true'. However, note that : c!=true
    // do something here
  } else {
    // this block is never called
  }
}


// the operators ===  and !== can be used to check real equality
1===1 //true
'1'===1 // false
'1'!==1 // true
```


# OOP

## Basic
```javascript
// anonymous object
var myObject = {
  firstname:'John',
  surname:'Doe',
  sayHello:function() {console.log('hello'+this.firstname)}
}

// an object is also a dictionary
console.log(myObject.firstname)
console.log(myObject['firstname'])

function Person(firstname, surname){
  this.firstname = firstname;
  this.surname = surname;
  this.sayHello = function(w) { console.log(w+ ' '+this.firstname); };
}

// the keyword 'new' creates a new local object named 'this'
// in this case, the function behaves like a constructor
var myObject = new Person('John','Doe');
myObject.sayHello(); // writes 'hello John' in the console

// the function MyClass can also be called. However, in this case, 'this' has not been created!
// by default, 'this' points to the global scope 'window'
var myObject = Person(1,'ok'); // null
window.sayHello(); // writes 'hello 1' in the console
```

## Prototypes
```javascript
function Person(firstname, surname){
  this.firstname = firstname;
  this.surname = surname;
}
Person.prototype.sayHello = function() {console.log('hello'+this.firstname)};
Person.prototype.someVar = 42;

new Person('John', 'Doe').sayHello() // 'hello John'
new Person('John', 'Doe').someVar // 42

// alternative syntax:
Person.prototype = {
  someVar:42,
  sayHello: function() {console.log('hello'+this.firstname)}
}
// or
function sayHelloGlobal() {console.log('hello'+this.firstname)}
Person.prototype.someVar = 42;
Person.prototype.sayHello = sayHelloGlobal;
```


## Advanced
```javascript
// any function can be called as if it was a method of the class
function sayHello(helloInEnglish, somethingElse) {
  console.log(helloInEnglish+this.firstName+'. '+somethingElse)
};
var myObject = {firstName:'John', surname:'Doe'};
sayHello.call(myObject, 'hello', 'How are you?') // writes 'hello John. How are you?' in the console
sayHello.apply(myObject, ['hello', 'How are you?']) // same as above
var newFuncWithObjectInContext = sayHello.bind(myObject);   newFuncWithObjectInContext('Hello', 'How are you?') // same as above. here, the variable 'this' contains 'o'


// reflexion
for(var memberName in myObject) {
  console.log(memberName+'='+myObject[memberName])
}
```


# Functional programming


## Functions are first-class citizens

```javascript
// anonymous function declaration assigned to a named variable
// exactely equivalent to: function myFunction(a,b,c,d) {
var myFunction = function() {
  return 0;
}
// again, same function declaration...
var myOtherFunction = function myFunction(a,b,c,d) {
  return 0;
}
myOtherFunction('axx','bxx','cxx','dxx');

// anonymous function immediately executed with parameters
(function(s,n) {
  console.log('s=' + s);
  console.log('n=' + n);
})('a', 1)

// functions can be passed as arguments and executed/manipulated
function myFunction2(predicate1, predicate2, a, b) {
  if(predicate1(a) && predicate2(a,b)) {
    return myFunction;
  } else {
    return function() { return b; };
  }
}

setTimeout(function(){ console.log('hello') }, 1000);
setTimeout(myFunction, 1000);

```

## Closures
```javascript
function sayHelloInFiveSeconds(name){
    var prompt = "Hello, " + name + "!";
    function inner(){
        alert(prompt);
    }
    setTimeout(inner, 5000);
}
sayHelloInFiveSeconds("Adam"); // will open a popup with "Hello, Adam!" in 5s
```

## Binding and Currying


# Advances OOP and OOP Design patterns applied to javascript
## Namespaces and Modules
// TODO

## Singleton
Does not exist. All properties are public

## Factory and Builders
// TODO

## Strategy
// TODO

## Wrapper / Proxy
```javascript
var p = new Person('John', 'Doe');
function traceAllFunctions(myObject) {
  for(var memberName in myObject) {
    var value = myObject[memberName];
    console.log(memberName+'='+value)
    if(typeof value == 'function') {
      myObject[memberName] = function(/*a,b,c,d,e,f,g,h,i,j,k,l,m,n*/) {
        console.log('function '+memberName+' is being called');
        var returnValue = value.apply(myObject, arguments/* [a,b,c,d,e,f,g,h,i,j,k,l,m,n] */);
        console.log('function '+memberName+' finished exec');
        return returnValue;
      }
    }
  }
}

traceAllFunctions(p);
p.sayHello(); // writes 'function sayHello is being called', 'hello John', 'function sayHello finished exec'

```
