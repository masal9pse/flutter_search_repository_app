sealed class Result<T, E extends Exception> {
  const Result();
}

final class Success<T,E extends Exception> extends Result<T,E> {
  const Success({required this.data});

  final T data;
}

final class Error<T,E extends Exception> extends Result<T,E> {
  const Error({required this.exception});

  final E exception;
}
