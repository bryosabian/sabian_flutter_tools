import 'package:flutter_debouncer/flutter_debouncer.dart';

class SabianDebounceTask<T> {
  final int debounceMilliseconds;
  final Debouncer _debouncer = Debouncer();
  final void Function(T)? onComplete;
  final void Function(Exception)? onError;

  final void Function()? onCancel;

  SabianDebounceTask(
      {required this.debounceMilliseconds,
      this.onComplete,
      this.onError,
      this.onCancel});

  void run(
    T Function() action,
  ) {
    T? result;
    _debouncer.debounce(
        duration: Duration(milliseconds: debounceMilliseconds),
        onDebounce: () {
          try {
            result = action.call();
            _complete(result);
          } on Exception catch (e) {
            _error(e);
          } on Error catch (e) {
            _error(Exception(e));
          }
        },
        type: BehaviorType.trailingEdge);
  }

  void cancel() {
    _debouncer.cancel();
    onCancel?.call();
  }

  void _error(Exception e) {
    onError?.call(e);
  }

  void _complete(T? result) {
    if (result != null) {
      onComplete?.call(result);
    } else {
      cancel();
    }
  }
}
