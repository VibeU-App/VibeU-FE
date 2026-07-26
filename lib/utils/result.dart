
// Result classes based on Flutter Result pattern
// consult Flutter design patterns page for more info
abstract class Result<T> {
  const Result();

  factory Result.ok(T value) => Ok._(value);
  factory Result.error(Exception exception) => Error._(exception);
}

class Ok<T> extends Result<T> {
  const Ok._(this.value);

  final T value;
}

class Error<T> extends Result<T> {
  const Error._(this.exception);

  final Exception exception;
}
