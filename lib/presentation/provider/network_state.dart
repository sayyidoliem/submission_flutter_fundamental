sealed class NetworkState<T> {
  const NetworkState();
}

final class Idle<T> extends NetworkState<T> {
  const Idle();
}

final class Loading<T> extends NetworkState<T> {
  const Loading();
}

final class Success<T> extends NetworkState<T> {
  final T data;
  const Success(this.data);
}

final class Failure<T> extends NetworkState<T> {
  final String message;
  final Object? error;
  const Failure(this.message, [this.error]);
}
