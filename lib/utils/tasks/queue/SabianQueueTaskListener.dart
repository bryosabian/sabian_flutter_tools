import 'dart:async';

class SabianQueueTaskListener<Q> {
  Future<Q> Function(Q) onExecute;
  Function(Q)? onQueued;
  Function(Q)? onProcessing;
  Function(Q)? onCompleted;
  Function(Exception, Q?)? onFailed;
  Function(Exception?)? onAllCompleted;

  SabianQueueTaskListener({
    required this.onExecute,
    this.onQueued,
    this.onProcessing,
    this.onCompleted,
    this.onFailed,
    this.onAllCompleted,
  });
}
