part of mapper_box;

class MapperCallbackMark {
  final Type first;

  final Type second;

  MapperCallbackMark(this.first, this.second);

  @override
  bool operator ==(other) {
    if (other is MapperCallbackMark) {
      return first == other.first && second == other.second;
    } else {
      return false;
    }
  }

  @override
  int get hashCode {
    var hashCode = super.hashCode;

    return hashCode;
  }
}
