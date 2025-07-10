import 'dart:isolate';

import 'package:easy_isolate/easy_isolate.dart';
import 'package:sabian_tools/extensions/Strings+Sabian.dart';
import 'package:sabian_tools/utils/tasks/SabianDebounceTask.dart';
import 'dart:core';

import 'package:sabian_tools/utils/utils.dart';

typedef OnSearched<T> = void Function(List<T>);
typedef SearchCriteriaCallBack<T> = List<String?> Function(T);
typedef OnSearchError = void Function(Exception);
typedef OnCancel = void Function(Exception?);
typedef OnBeforeSearch = void Function();

class SabianLinearDataSearcher<T> {
  SabianDebounceTask<void>? _debounceTask;
  String? query;

  Worker? _worker;

  bool isComplete = false;
  final int debounceMilliseconds;
  final int differentThreadThreshold;

  final OnSearched<T>? onSearched;
  final OnSearchError? onSearchError;
  final OnCancel? onCancel;
  final OnBeforeSearch? onBefore;

  /// What to search for
  SearchCriteriaCallBack<T> searchCriteria;

  SabianLinearDataSearcher(
      {required this.onSearched,
      required this.searchCriteria,
      this.onSearchError,
      this.onCancel,
      this.onBefore,
      this.debounceMilliseconds = 300,
      this.differentThreadThreshold = 500});

  SabianLinearDataSearcher.withOutCallBacks(
      {required this.searchCriteria,
      this.debounceMilliseconds = 0,
      this.differentThreadThreshold = 500,
      this.onSearched,
      this.onSearchError,
      this.onCancel,
      this.onBefore});

  ///Runs a search
  void search(List<T> content, String query) {
    this.query = query;
    _onBeforeSearch();
    _debounceSearch(content, query);
  }

  void _debounceSearch(List<T> content, String query) {
    _debounceTask ??= SabianDebounceTask(
        debounceMilliseconds: debounceMilliseconds,
        onCancel: () {
          _cancelTasks(cancelDebounce: false);
        });
    _debounceTask!.run(() {
      _startSearch(content, query);
    });
  }

  void _startSearch(List<T> content, String query) async {
    if (_isTooBigForMainThread(content)) {
      //Always await for this to complete the new thread initialization
      await Future(() => _searchIsolate(content, query));
      return;
    }
    _searchAsync(content, query);
  }

  void _searchIsolate(List<T> content, String query) async {
    _killIsolate();

    _worker = Worker();

    await _worker!.init(

        //MainHandler
        (dynamic data, SendPort isolatePort) {
          if (data is List<T>) {
            isComplete = true;
            _onSearched(data);
          }
        },

        //IsolateHandler
        _isolateSearch<T>,

        //Error Handler
        errorHandler: (dynamic data) {
          _onError(data);
        },

        //Exit Handler
        exitHandler: (data) {
          _onCancel(data);
        },
        initialMessage: [content, query, searchCriteria]);
  }

  List<T> directSearch(List<T> content, String query) {
    return searchContentFor<T>(content, query, searchCriteria);
  }

  void _searchAsync(List<T> content, String query) {
    Future(() {
      List<T> newContent = directSearch(content, query);
      return newContent;
    }).then((value) {
      isComplete = true;
      _onSearched(value);
    }).onError((error, stackTrace) {
      _onError(error);
    });
  }

  /// Cancels the search operation
  void cancel() {
    try {
      _cancelTasks();
      onCancel?.call(null);
    } on Exception catch (e) {
      sabianPrint(e.toString());
    }
  }

  void _onBeforeSearch() {
    isComplete = false;
    onBefore?.call();
  }

  void _onSearched(List<T> newContent) {
    if (isComplete) {
      onSearched?.call(newContent);
    } else {
      onCancel?.call(null);
    }
  }

  void _onError(dynamic e) {
    Exception throwable;
    if (e is Exception) {
      throwable = e;
    } else {
      throwable = Exception(e);
    }
    onSearchError?.call(throwable);
  }

  void _onCancel(dynamic e) {
    Exception? throwable;
    if (e != null) {
      if (e is Exception) {
        throwable = e;
      } else {
        throwable = Exception(e);
      }
    }
    onCancel?.call(throwable);
  }

  bool _isTooBigForMainThread(List<T> all) {
    return all.length >= differentThreadThreshold;
  }

  void _cancelTasks({bool cancelDebounce = true}) {
    try {
      _killIsolate();
      if (cancelDebounce && _debounceTask != null) {
        _debounceTask?.cancel();
      }
    } catch (e) {
      //Do nothing
    }
  }

  void _killIsolate() {
    if (_worker != null && _worker!.isInitialized) {
      _worker!.dispose(immediate: true);
    }
    _worker = null;
  }

  void dispose() {
    _killIsolate();
  }

  ///List<dynamic> args = data;
  ///       List<T> searchData = args[0];
  ///       String searchFor = args[1];
  ///       List<String?> Function(T) criteriaCallBack = args[2];
  static void _isolateSearch<T>(
      dynamic data, SendPort mainPort, SendErrorFunction onSendError) {
    try {
      List<dynamic> args = data;
      List<T> searchData = args[0];
      String searchFor = args[1];
      SearchCriteriaCallBack<T> criteriaCallBack = args[2];
      List<T> searched = searchContentFor(searchData, searchFor, criteriaCallBack);
      mainPort.send(searched);
    } on Exception catch (e) {
      onSendError(e);
    }
  }

  static List<T> searchContentFor<T>(List<T> allContents, String search,
      SearchCriteriaCallBack<T> criteriaCallBack,
      {bool growable = false}) {
    return allContents.where((element) {
      return hasAnyMatch(search, criteriaCallBack.call(element));
    }).toList(growable: growable);
  }

  static bool hasAnyMatch(String search, List<String?> criteria) {
    return criteria.any((searchContext) {
      return searchContext.isAMatchByKeyWord(search);
    });
  }
}
