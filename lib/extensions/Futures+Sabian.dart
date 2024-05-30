Future<E> futureWithDelay<E>(Duration delay, Future<E> Function() future,
    {bool isBeforeExecution = true}) async {
  if (isBeforeExecution) {
    await Future.delayed(delay);
  }
  final value = await future.call();

  if (!isBeforeExecution) {
    await Future.delayed(delay);
  }
  return value;
}

Future<E> futureWithSlightDelay<E>(Future<E> Function() future,
    {bool isBeforeExecution = true}) {
  return futureWithDelay(const Duration(microseconds: 300), future,
      isBeforeExecution: isBeforeExecution);
}
