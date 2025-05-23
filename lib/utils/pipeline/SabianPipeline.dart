import 'ISabianPipeHandler.dart';
class SabianPipeline<I, O> {
  final ISabianPipeHandler<I, O> _currentHandler;

  SabianPipeline(this._currentHandler);

  SabianPipeline<I, K> addHandler<K>(ISabianPipeHandler<O, K> newHandler) {
    return SabianPipeline<I, K>(
      _CompositeHandler<I, O, K>(_currentHandler, newHandler),
    );
  }

  O execute(I input) {
    return _currentHandler.process(input);
  }
}

// Helper class to compose handlers, not strictly necessary to be public
// but makes the addHandler logic cleaner.
class _CompositeHandler<I, Intermediate, K> implements ISabianPipeHandler<I, K> {
  final ISabianPipeHandler<I, Intermediate> _firstHandler;
  final ISabianPipeHandler<Intermediate, K> _secondHandler;

  _CompositeHandler(this._firstHandler, this._secondHandler);

  @override
  K process(I input) {
    final intermediateResult = _firstHandler.process(input);
    return _secondHandler.process(intermediateResult);
  }
}