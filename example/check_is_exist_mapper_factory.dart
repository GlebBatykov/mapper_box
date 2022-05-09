import 'package:mapper_box/mapper_box.dart';

void main() {
  MapperBox.instanse.register<int, String>((object) => object.toString());

  var isExist = MapperBox.instanse.isExistMapper<int, String>();

  print(isExist);
}
