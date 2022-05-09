part of mapper_box;

class MapperBoxException implements Exception {
  final String? message;

  MapperBoxException({this.message});

  @override
  String toString() {
    if (message != null) {
      return runtimeType.toString() + ': ' + message!;
    } else {
      return super.toString();
    }
  }
}
