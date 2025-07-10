import 'dart:isolate';

import 'package:easy_isolate/easy_isolate.dart';

class SabianAsyncTask<T> {
  final T Function() action;
  final void Function(T) onComplete;
  final void Function(Exception, StackTrace?) onError;
  final bool useIsolate;

  Worker? _worker;

  SabianAsyncTask(this.action, this.onComplete, this.onError,
      {this.useIsolate = false});

  Future<void> execute() async {
    if (useIsolate) {
      await _executeIsolate();
    } else {
      await _executeFuture();
    }
  }


  Future<void> _executeFuture() async {
    Future<T>(action).then(onComplete).onError((error, stackTrace) {
      onError(Exception(error), stackTrace);
    });
  }

  Future<void> _executeIsolate() async {
    _killIsolate();
    _worker = Worker();

    await _worker!.init(
        //MainHandler
        (dynamic data, SendPort isolatePort) {
          if (data is T) {
            onComplete(data);
          }
        },

        //Isolate action
        _isolateAction<T>,

        //Error Handler
        errorHandler: (dynamic data) {
          if(data is List){
            final message = data.map((e) => e.toString()).join(",");
            onError(Exception(message), null);
            return;
          }
          if(data is Exception){
            onError(data, null);
            return;
          }
          if(data is Error){
            onError(Exception(data.toString()), null);
            return;
          }
          onError(Exception("Unknown Error"), null);
        },

        //Initial message
        initialMessage: action);
  }

  void _killIsolate() {
    if (_worker != null) {
      if (_worker!.isInitialized) {
        _worker!.dispose(immediate: true);
      }
      _worker = null;
    }
  }

  static void _isolateAction<T>(
      dynamic data, SendPort mainPort, SendErrorFunction onSendError) {
    try {
      T Function() action = data as T Function();
      T value = action();
      mainPort.send(value);
    } on Exception catch (e) {
      onSendError(e);
    }
  }
}
