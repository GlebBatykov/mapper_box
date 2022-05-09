import 'package:mapper_box/mapper_box.dart';
import 'package:test/test.dart';

void main() {
  group('mapper_box', () {
    late MapperBox mapperBox;

    setUp(() {
      mapperBox = MapperBox.newInstanse;
    });

    test('.register(). ', () {
      late bool isExist;

      isExist = mapperBox.isExistMapper<int, String>();

      expect(isExist, false);

      mapperBox.register<int, String>((object) => object.toString());

      isExist = mapperBox.isExistMapper<int, String>();

      expect(isExist, true);
    });

    test('.map(). ', () {
      mapperBox.register<int, String>((object) => object.toString());

      var result = mapperBox.map<int, String>(22);

      expect(result, '22');
    });

    test('.mapAsync(). ', () async {
      mapperBox.register<int, String>((object) async {
        return await Future(() => object.toString());
      });

      var result = await mapperBox.mapAsync<int, String>(22);

      expect(result, '22');
    });

    test('.isExistMapper(). ', () {
      late bool isExist;

      isExist = mapperBox.isExistMapper<int, String>();

      expect(isExist, false);
    });
  });
}
