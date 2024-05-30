import 'package:sabian_tools/extensions/Queues+Sabian.dart';
import 'package:sabian_tools/utils/tasks/queue/SabianQueueTaskManager.dart';

class SabianQueueTaskAsyncManager<Q> extends SabianQueueTaskManager<Q> {
  SabianQueueTaskAsyncManager({required super.listener});

  Future<void> enqueueAsync(Q item, {bool startImmediate = true}) async {
    await lock.synchronized(() async {
      if (!queue.contains(item)) {
        queue.add(item);
      }
      if (isProcessing) {
        listener.onQueued?.call(item);
      }
    });
    if (startImmediate && !isProcessing) {
      await runNext();
    }
  }

  @override
  Future<void> runNext() async {
    await lock.synchronized(() async {
      if (isProcessing) {
        return;
      }
      onLastQueueCompleted();
      isProcessing = true;
      final next = queue.pop();
      if (next != null) {
        await execute(next);
      } else {
        await onComplete();
      }
    });
  }

  @override
  Future<void> execute(Q item) async {
    listener.onProcessing?.call(item);
    lastQueueItem = item;
    try {
      final value = await listener.onExecute.call(item);
      await completeAndRunNext(value);
    } on Exception catch (e) {
      await failAndRunNext(item, error: e);
    }
  }

  @override
  Future<void> completeAndRunNext(Q item) async {
    await complete(item, runNext: true);
  }

  @override
  Future<void> complete(Q item, {bool runNext = false}) async {
    onLastQueueCompleted(last: item);
    await lock.synchronized(() {
      isProcessing = false;
    });
    if (runNext) {
      await this.runNext();
    }
  }

  @override
  Future<void> fail(Q item, {Exception? error, bool runNext = false}) async {
    onLastQueueCompleted(last: item, e: error);
    await lock.synchronized(() {
      isProcessing = false;
    });
    if (runNext) {
      await this.runNext();
    }
  }

  @override
  Future<void> failAndRunNext(Q item, {Exception? error}) async {
    // TODO: implement failAndRunNext
    await fail(item, error: error, runNext: true);
  }

  @override
  Future<void> onComplete() async {
    await lock.synchronized(() {
      isProcessing = false;
    });
    listener.onAllCompleted?.call(null);
    onLastQueueCompleted();
  }
}
