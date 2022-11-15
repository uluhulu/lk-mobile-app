abstract class FutureUseCase<T, P> {
  Future<T> call(P params);
}

abstract class VoidUseCase<T> {
  T call();
}
