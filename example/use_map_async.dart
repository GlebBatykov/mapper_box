import 'package:mapper_box/mapper_box.dart';

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
