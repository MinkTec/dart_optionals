mixin OptionalBase<T> {
  T get unwrap;
}

class Option<T> with OptionalBase<T> {
  final T? some;

  Option(this.some);

  @override
  T get unwrap => some!;

  bool get isSome => some != null;
}

class Result<T, Err> with OptionalBase<T> {
  final T? ok;
  final Err? error;

  @override
  T get unwrap => ok!;

  bool get isOk => ok != null;

  Result({this.ok, this.error}) {
    assert((this.ok != null || this.error != null) &&
        (this.ok != null && this.error != null));
  }
}
