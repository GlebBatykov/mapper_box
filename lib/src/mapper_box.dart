part of mapper_box;

typedef MapperFactoryCallback<F, S> = FutureOr<S> Function(F object);

///
class MapperBox {
  static MapperBox? _instanse;

  final Map<MapperCallbackMark, Map<String?, Function>> _callbacks = {};

  MapperBox._();

  ///
  static MapperBox get instanse {
    return _instanse ?? (_instanse = MapperBox._());
  }

  ///
  static MapperBox get newInstanse {
    return _instanse = MapperBox._();
  }

  ///
  void register<F, S>(MapperFactoryCallback<F, S> factoryCallback,
      {String? name}) {
    var mark = MapperCallbackMark(F, S);

    if (_isExist(mark)) {
      _getCallbacksByMark(mark)![name] = factoryCallback;
    } else {
      _callbacks[mark] = {name: factoryCallback};
    }
  }

  ///
  S map<F, S>(F object, {String? name}) {
    var mark = MapperCallbackMark(F, S);

    if (!_isExist(mark)) {
      throw MapperBoxException();
    }

    var callbacks = _getCallbacksByMark(mark)!;

    if (!_isExistName(callbacks, name)) {
      throw MapperBoxException();
    }

    return callbacks[name]!.call(object as Object) as S;
  }

  ///
  Future<S> mapAsync<F, S>(F object, {String? name}) async {
    var mark = MapperCallbackMark(F, S);

    if (!_isExist(mark)) {
      throw MapperBoxException();
    }

    var callbacks = _getCallbacksByMark(mark)!;

    if (!_isExistName(callbacks, name)) {
      throw MapperBoxException();
    }

    return await callbacks[name]!.call(object as Object) as S;
  }

  bool isExistMapper<F, S>({String? name}) {
    var mark = MapperCallbackMark(F, S);

    if (!_isExist(mark)) {
      return false;
    }

    var callbacks = _getCallbacksByMark(mark)!;

    return _isExistName(callbacks, name);
  }

  bool _isExistName(Map<String?, Function> callbacks, String? name) {
    return callbacks.containsKey(name);
  }

  bool _isExist(MapperCallbackMark mark) {
    var isExist = false;

    for (var key in _callbacks.keys) {
      if (key == mark) {
        isExist = true;
        break;
      }
    }

    return isExist;
  }

  Map<String?, Function>? _getCallbacksByMark(MapperCallbackMark mark) {
    Map<String?, Function>? callbacks;

    for (var entry in _callbacks.entries) {
      if (entry.key == mark) {
        callbacks = entry.value;
        break;
      }
    }

    return callbacks;
  }
}
