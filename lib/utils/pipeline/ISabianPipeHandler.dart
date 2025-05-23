abstract class ISabianPipeHandler<I, O> {
  O process(I input);
}

abstract class ISabianFuturePipeHandler<I, O> {
  Future<O> process(I input);
}
