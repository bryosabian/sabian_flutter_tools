import 'dart:collection';

import 'package:sabian_tools/extensions/Queues+Sabian.dart';
import 'package:sabian_tools/utils/tasks/queue/SabianQueueTaskListener.dart';
import 'package:synchronized/synchronized.dart';

class SabianQueueTaskManager<Q> {
  final SabianQueueTaskListener<Q> listener;

  final ListQueue<Q> _queue = ListQueue();

  bool _isProcessing = false;

  Q? _lastQueueItem;

  final _lock = Lock();

  SabianQueueTaskManager({
    required this.listener,
  });

  void enqueue(Q item, {bool startImmediate = true}) async {
    await _lock.synchronized(() async {
      if (!_queue.contains(item)) {
        _queue.add(item);
      }
      if (_isProcessing) {
        listener.onQueued?.call(item);
      }
    });
    if (startImmediate && !_isProcessing) {
      runNext();
    }
  }

  void runNext() async {
    _lock.synchronized(() async {
      if (_isProcessing) {
        return;
      }
      _onLastQueueCompleted();
      _isProcessing = true;
      final next = _queue.pop();
      if (next != null) {
        _execute(next);
      } else {
        _onComplete();
      }
    });
  }

  void _execute(Q item) {
    listener.onProcessing?.call(item);
    _lastQueueItem = item;
    listener.onExecute.call(item).then((value) {
      _completeAndRunNext(value);
    }).catchError((e) {
      _failAndRunNext(item, error: e);
    });
  }

  void _completeAndRunNext(Q item) {
    _complete(item, runNext: true);
  }

  void _complete(Q item, {bool runNext = false}) async {
    _onLastQueueCompleted(last: item);
    await _lock.synchronized(() {
      _isProcessing = false;
    });
    if (runNext) {
      this.runNext();
    }
  }

  void _failAndRunNext(Q item, {Exception? error}) {
    _fail(item, error: error, runNext: true);
  }

  void _fail(Q item, {Exception? error, bool runNext = false}) async {
    _onLastQueueCompleted(last: item, e: error);
    await _lock.synchronized(() {
      _isProcessing = false;
    });
    if (runNext) {
      this.runNext();
    }
  }

  void _onComplete() async {
    await _lock.synchronized(() {
      _isProcessing = false;
    });
    listener.onAllCompleted?.call(null);
    _onLastQueueCompleted();
  }

  void _onLastQueueCompleted({Q? last, Exception? e}) {
    final mLast = last ?? _lastQueueItem;
    if (mLast != null) {
      if (e != null) {
        listener.onFailed?.call(e, mLast);
      } else {
        listener.onCompleted?.call(mLast);
      }
    }
    _lastQueueItem = null;
  }
}
