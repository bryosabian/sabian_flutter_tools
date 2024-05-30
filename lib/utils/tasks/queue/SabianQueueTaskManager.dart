import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:sabian_tools/extensions/Queues+Sabian.dart';
import 'package:sabian_tools/utils/tasks/queue/SabianQueueTaskListener.dart';
import 'package:synchronized/synchronized.dart';

class SabianQueueTaskManager<Q> {
  final SabianQueueTaskListener<Q> listener;

  @protected
  final ListQueue<Q> queue = ListQueue();

  @protected
  bool isProcessing = false;

  @protected
  Q? lastQueueItem;

  @protected
  final lock = Lock();

  SabianQueueTaskManager({
    required this.listener,
  });

  void enqueue(Q item, {bool startImmediate = true}) async {
    await lock.synchronized(() async {
      if (!queue.contains(item)) {
        queue.add(item);
      }
      if (isProcessing) {
        listener.onQueued?.call(item);
      }
    });
    if (startImmediate && !isProcessing) {
      runNext();
    }
  }

  void runNext() async {
    lock.synchronized(() async {
      if (isProcessing) {
        return;
      }
      onLastQueueCompleted();
      isProcessing = true;
      final next = queue.pop();
      if (next != null) {
        execute(next);
      } else {
        onComplete();
      }
    });
  }

  @protected
  void execute(Q item) {
    listener.onProcessing?.call(item);
    lastQueueItem = item;
    listener.onExecute.call(item).then((value) {
      completeAndRunNext(value);
    }).catchError((e) {
      failAndRunNext(item, error: e);
    });
  }

  @protected
  void completeAndRunNext(Q item) async {
    complete(item, runNext: true);
  }

  @protected
  void complete(Q item, {bool runNext = false}) async {
    onLastQueueCompleted(last: item);
    await lock.synchronized(() {
      isProcessing = false;
    });
    if (runNext) {
      this.runNext();
    }
  }

  @protected
  void failAndRunNext(Q item, {Exception? error}) {
    fail(item, error: error, runNext: true);
  }

  @protected
  void fail(Q item, {Exception? error, bool runNext = false}) async {
    onLastQueueCompleted(last: item, e: error);
    await lock.synchronized(() {
      isProcessing = false;
    });
    if (runNext) {
      this.runNext();
    }
  }

  @protected
  void onComplete() async {
    await lock.synchronized(() {
      isProcessing = false;
    });
    listener.onAllCompleted?.call(null);
    onLastQueueCompleted();
  }

  @protected
  void onLastQueueCompleted({Q? last, Exception? e}) {
    final mLast = last ?? lastQueueItem;
    if (mLast != null) {
      if (e != null) {
        listener.onFailed?.call(e, mLast);
      } else {
        listener.onCompleted?.call(mLast);
      }
    }
    lastQueueItem = null;
  }
}
