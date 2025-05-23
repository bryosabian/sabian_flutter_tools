import 'ISabianPipeHandler.dart';

class SabianFuturePipeline<I, O> {
  final ISabianFuturePipeHandler<I, O> _currentHandler;

  SabianFuturePipeline(this._currentHandler);

  SabianFuturePipeline<I, K> addHandler<K>(ISabianFuturePipeHandler<O, K> newHandler) {
    return SabianFuturePipeline<I, K>(
      _CompositeHandler<I, O, K>(_currentHandler, newHandler),
    );
  }

  Future<O> execute(I input) {
    return _currentHandler.process(input);
  }
}

// Helper class to compose handlers, not strictly necessary to be public
// but makes the addHandler logic cleaner.
class _CompositeHandler<I, Intermediate, K> implements ISabianFuturePipeHandler<I, K> {
  final ISabianFuturePipeHandler<I, Intermediate> _firstHandler;
  final ISabianFuturePipeHandler<Intermediate, K> _secondHandler;

  _CompositeHandler(this._firstHandler, this._secondHandler);

  @override
  Future<K> process(I input) async {
    final intermediateResult = await _firstHandler.process(input);
    return _secondHandler.process(intermediateResult);
  }
}