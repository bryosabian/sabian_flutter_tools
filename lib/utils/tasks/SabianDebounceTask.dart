import 'dart:async';

class SabianDebounceTask<T> {
  final int debounceMilliseconds;
  Timer? _timer;
  final void Function(T)? onComplete;
  final void Function(Exception)? onError;

  final void Function()? onCancel;

  bool get isActive => _timer?.isActive ?? false;

  SabianDebounceTask(
      {required this.debounceMilliseconds,
      this.onComplete,
      this.onError,
      this.onCancel});

  void run(
    T Function() action,
  ) {
    cancel();
    T? result;
    _timer = Timer(Duration(milliseconds: debounceMilliseconds), () {
      try {
        result = action.call();
        _complete(result);
      } on Exception catch (e) {
        _error(e);
      } on Error catch (e) {
        _error(Exception(e));
      }
    });
  }

  void cancel() {
    _timer?.cancel();
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
