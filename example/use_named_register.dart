import 'package:mapper_box/mapper_box.dart';

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
