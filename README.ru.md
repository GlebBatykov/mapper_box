</div>

<div align="center">

**Языки:**
  
[![English](https://img.shields.io/badge/Language-English-blue?style=?style=flat-square)](README.md)
[![Russian](https://img.shields.io/badge/Language-Russian-blue?style=?style=flat-square)](README.ru.md)

</div>

- [Введение](#введение)
- [Про MapperBox](#про-mapperbox)
- [Установка](#установка)
- [Использование](#использование)
  - [Асинхронная конвертация](#асинхронная-конвертация)

# Введение

При разработке приложений на Dart-е я периодически сталкиваюсь с необходимостью конвертацией одних моделей в другие. Из за отсутствия рефлексии при AOT компиляции в Dart отсутствуют пакеты для автоматической конвертации (хотя такое возможно реализовать для JIT компиляции при помощи dart:mirrors). Этот пакет представляет собой простую обертку, для того чтобы хранить правила конвертации типов в одном месте приложения.

# Про MapperBox

Этот пакет представляет собой обертку, хранилище хранящее заданные правила конвертации типов в вашем приложении.

# Установка

Добавьте MapperBox в ваш pubspec.yaml файл:

```dart
dependencies:
  mapper_box: ^1.0.0
```

Импортируйте ossa в файле где он должен использоваться:

```dart
import 'package:mapper_box/mapper_box.dart';
```

# Использование

Регистрация функций конверторов осуществляется при помощи метода register<F, S> класса MapperBox, который принимает в качестве аргумента FutureOr<S> Function(F) функцию.

Конвертация при помощи зарегистрированных ранее функций конверторов осуществляется при помощи метода map<F, S> класса MapperBox, который принимает в качестве аргумента объект типа F, а возвращает объект типа S.

Пример регистрации функции конвертора, использование конвертации:

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

Ожидаемый вывод:

```dart
User with name: Alex, age: 22.
```

## Асинхронная конвертация

Во время конвертации одного типа в другой вам может понадобится вызвать асинхронный код, функция конвертер регистрируемая при помощи метода register<F, S> возвращает FutureOr<S>, то есть может возвращать Future.

Для асинхронной конвертации используется метод mapAsync<F, S>, который принимает в качестве аргумента объект типа F, возвращает Future<S>.

Пример использования асинхронной конвертации:

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

Ожидаемый вывод:

```dart
User with name: Alex, age: 22.
```
