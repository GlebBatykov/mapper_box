<div align="center">

**Язык:**
  
[![English](https://img.shields.io/badge/Language-English-blue?style=?style=flat-square)](https://github.com/GlebBatykov/mapper_box/tree/main/example/README.md)
[![Russian](https://img.shields.io/badge/Language-Russian-blue?style=?style=flat-square)](https://github.com/GlebBatykov/mapper_box/tree/main/example/README.ru.md)
  
</div>

- [Конвертация](#конвертация)
- [Асинхронная конвертация](#асинхронная-конвертация)
- [Проверка существования функции конвертера](#проверка-существования-функции-конвертера)
- [Использование именнованной регистрации](#использование-именнованной-регистрации)

# Конвертация

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

# Асинхронная конвертация

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

# Проверка существования функции конвертера

```dart
void main() {
  MapperBox.instanse.register<int, String>((object) => object.toString());

  var isExist = MapperBox.instanse.isExistMapper<int, String>();

  print(isExist);
}
```

# Использование именнованной регистрации

```dart
class Animal {
  final String name;

  Animal(this.name);
}

class Cat {
  final String name;

  Cat(this.name);

  @override
  String toString() {
    return name;
  }
}

void main() {
  MapperBox.instanse.register<Animal, Cat>(
      (object) => Cat(object.name + ' first!'),
      name: 'first');

  MapperBox.instanse.register<Animal, Cat>(
      (object) => Cat(object.name + ' second!'),
      name: 'second');

  var animal = Animal('Alex');

  print(MapperBox.instanse.map<Animal, Cat>(animal, name: 'first'));

  print(MapperBox.instanse.map<Animal, Cat>(animal, name: 'second'));
}
```
