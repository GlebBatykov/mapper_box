</div>

<div align="center">

**Languages:**
  
[![English](https://img.shields.io/badge/Language-English-blue?style=?style=flat-square)](README.md)
[![Russian](https://img.shields.io/badge/Language-Russian-blue?style=?style=flat-square)](README.ru.md)

</div>

- [Introduction](#introduction)
- [About MapperBox](#about-mapperbox)
- [Installing](#installing)
- [Using](#using)
  - [Asynchronous mapping](#asynchronous-mapping)

# Introduction

When developing applications on Dart, I periodically encounter the need to convert some models into others. Due to the lack of reflection during AOT compilation, there are no packages for automatic conversion in Dart (although it is possible to implement this for JIT compilation using dart:mirrors). This package is a simple wrapper to store the type conversion rules in one place of the application.

# About MapperBox

This package is a wrapper, a repository that stores the specified type conversion rules in your application.

# Installing

Add MapperBox to your pubspec.yaml file:

```dart
dependencies:
  mapper_box: ^1.0.1
```

Import ossa in file that it will be used:

```dart
import 'package:mapper_box/mapper_box.dart';
```

# Using

The converter function is registered using the register&lt;F, S&gt; method of the MapperBox class, which takes the FutureOr&lt;S&gt; Function(F) function as an argument.

Conversion using previously registered converter functions is performed using the map&lt;F, S&gt; method of the MapperBox class, which takes an object of type F as an argument, and returns an object of type S.

Example of registering a converter function, using conversion:

```dart
class DatabaseUser {
  final int id;

  final String name;

  final int age;

  DatabaseUser(this.id, this.name, this.age);
}

class User {
  final String name;

  final String age;

  User(this.name, this.age);

  @override
  String toString() {
    return 'User with name: $name, age: $age.';
  }
}

void main() {
  MapperBox.instanse.register<DatabaseUser, User>(
      (object) => User(object.name, object.age.toString()));

  var databaseUser = DatabaseUser(0, 'Alex', 22);

  var user = MapperBox.instanse.map<DatabaseUser, User>(databaseUser);

  print(user);
}
```

Expacted output:

```dart
User with name: Alex, age: 22.
```

## Asynchronous mapping

During the conversion of one type to another, you may need to call asynchronous code, the converter function registered using the register&lt;F, S&gt; method returns FutureOr&lt;S&gt;, that is, it can return Future.

For asynchronous conversion, the map Async&lt;F, S&gt; method is used, which takes an object of type F as an argument, returns Future&lt;S&gt;.

An example of using asynchronous conversion:

```dart
class DatabaseUser {
  final int id;

  final String name;

  DatabaseUser(this.id, this.name);
}

class User {
  final String name;

  final int age;

  User(this.name, this.age);

  @override
  String toString() {
    return 'User with name: $name, age: $age.';
  }
}

Future<int> getAgeFromFuture() async {
  return 22;
}

void main() async {
  MapperBox.instanse.register<DatabaseUser, User>((object) async {
    var age = await getAgeFromFuture();

    return User(object.name, age);
  });

  var databaseUser = DatabaseUser(0, 'Alex');

  var user =
      await MapperBox.instanse.mapAsync<DatabaseUser, User>(databaseUser);

  print(user);
}
```

Expacted output:

```dart
User with name: Alex, age: 22.
```
