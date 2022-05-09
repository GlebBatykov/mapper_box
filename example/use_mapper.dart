import 'package:mapper_box/mapper_box.dart';

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
