mixin OptionalBase<T> {
  T? _val;

  T unwrap() => _val!;

  T unwrapOr(T t) => _val ?? t;

  bool get _isValid => _val != null;

  T expect(String message) {
    try {
      return unwrap();
    } catch (e) {
      print(message);
      rethrow;
    }
  }
}

class Option<T> with OptionalBase<T> {
  Option(T? val) {
    super._val = val;
  }

  bool get isSome => _isValid;
  bool get isNone => !isSome;

  @override
  String toString() => "Option($_val)";
}

class Result<T> with OptionalBase<T> {
  late final Object? error;

  Result(Object object) {
    try {
      super._val = object as T;
      error = null;
    } catch (_) {
      error = object;
      _val = null;
    }
  }

  bool get isOk => _isValid;

  bool get isErr => !isOk;

  @override
  String toString() => "Result(${isOk ? _val : error})";
}
