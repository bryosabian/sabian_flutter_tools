import 'ISabianPipeHandler.dart';

class FunctionPipeHandler<I,O> implements ISabianPipeHandler<I,O>  {

  final O Function(I input) _function;

  @override
  O process(I input) {
    return _function(input);
  }

  const FunctionPipeHandler(O Function(I input) function) : _function = function;
}

class FunctionAsyncPipeHandler<I,O> extends ISabianFuturePipeHandler<I,O>  {

  final Future<O> Function(I input) mFunction;

  FunctionAsyncPipeHandler(this.mFunction);

  @override
  Future<O> process(I input) async {
   final m = await mFunction(input);
   return m;
  }
}