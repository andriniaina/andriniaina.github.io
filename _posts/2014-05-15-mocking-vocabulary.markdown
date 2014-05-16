---
layout: post
categories: EN test
title: Test doubles and mocks, dummies, stubs, spies, fakes - some vocabulary
---

A test double (or mock object) is an object that mimics the real object by reimplementing its members. It will be used during tests to isolate the domain/class to be tested.

Test doubles can be categorized into 4 groups: Dummies, Stubs, Spies, Fakes.

# Dummies
A dummy is a basic object whose methods always return the default value of a given type (`null`, `0`, `false`, etc.).

Build a dummy when the domain to be tested should never use it, but still requires it in the API.

```csharp
class MembershipManagerDummy : IMembershipManager
{
	public User GetUser(int userId)
	{
		return null;
	}
}
```

> instead of returning a default value, it is also common to `throw new NotImplementedException()`

# Stubs
A stub is a basic object whose methods always return the same constant value.

Many stubs can be created in order to test different aspects of the domain to be tested.
For example, one can create a stub `MembershipManagerStub_AlwaysReturnGeorge` and another stub `MembershipManagerStub_AlwaysReturnPatricia`

```csharp
class MembershipManagerStub_AlwaysReturnGeorge : IMembershipManager
{
	public User GetUser(int userId)
	{
		return new User(){ FirstName="George"};
	}
}
```

> A dummy is a kind of stub that returns the type's default value

# Spies
A spy (aka verified mock) is a an object that tests and verifies how the domain uses the object. It tests the domain's **behavior** and is an assertion in itself.
As such, a spy must keep track of all the expected calls and be able to check if it has been properly used.

```csharp
class MembershipManagerSpy : IMembershipManager
{
	int GetUser_CallsCount = 0;
	public User GetUser(int userId)
	{
		GetUser_CallsCount += 1;
		return new User(){ FirstName="George"};
	}

	public void Verify()
	{
		if(GetUser_CallsCount!=1) throw new AssertionException("Wrong usage");
	}
}
```

> A stub is a kind of spy that does not verify anything

# Fakes
A fake implements a complex behavior, different from the object it is mocking.

```csharp
class MembershipManagerSpy : IMembershipManager
{
	public User GetUser(int userId)
	{
		if(userId<0) throw new ArgumentException();

		switch(userId)
		{
			case 4:
				return new User(){ FirstName="George"};
			case 5:
				return new User(){ FirstName="Patricia"};
			default:
				return null;
		}
	}
}
```

> A fake is neither a spy, nor a stub, nor a dummy.
> It just emulates the real object and provides a different (simpler) implementation.

# Mock frameworks
Of course, you don't have to write any of these verbose code.

You can build dummies, spies, stubs, fakes on the fly and in a few lines with mock frameworks (`Rhino.Mocks`, `Moq`, `NMock`, `FakeItEasy`, etc.)









