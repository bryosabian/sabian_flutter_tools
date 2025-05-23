import 'ISabianPipeHandler.dart';

class IdentityPipeHandler<T> implements ISabianPipeHandler<T, T> {
  @override
  T process(T input) {
    return input;
  }
}

class IdentityAsyncPipeHandler<T> implements ISabianFuturePipeHandler<T, T> {
  @override
  Future<T> process(T input) async {
    return input;
  }
}