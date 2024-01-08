mixin OptionalBase<T> {
  late final T? _val;

  T unwrap() => _val!;

  T unwrapOr(T t) => _val ?? t;

  bool get _isValid => _val != null;

  // ignore: null_check_on_nullable_type_parameter
  S? map<S>(S Function(T x) fn) => _isValid ? fn(_val!) : null;

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

extension OptionalIterables<T> on Iterable<OptionalBase<T>> {
  Iterable<S> filterMap<S>(S Function(T value) fn) =>
      where((x) => x._isValid).map((x) => fn(x.unwrap()));
}
