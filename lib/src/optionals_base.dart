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
  @override
  final T? _val;

  Option(this._val);

  bool get isSome => _isValid;
  bool get isNone => !isSome;
}

class Result<T, Err> with OptionalBase<T> {
  final T? ok;
  final Err? error;

  Result({this.ok, this.error}) {
    super._val = ok;
    assert((this.ok != null || this.error != null) &&
        (this.ok != null && this.error != null));
  }

  bool get isOk => ok != null;

  bool get isErr => !isOk;
}
