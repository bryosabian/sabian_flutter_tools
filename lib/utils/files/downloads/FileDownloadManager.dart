import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:path/path.dart';
import 'package:sabian_tools/extensions/Strings+Sabian.dart';
import 'package:sabian_tools/utils/files/downloads/FileDownloadListener.dart';

class FileDownloadManager {
  static Directory get _defaultDirectory => Directory("Downloads");

  Directory? storageFolder;
  FileDownloadListener? listener;

  Duration? timeOut;

  late final DioForNative _client = DioForNative(BaseOptions(
      connectTimeout: timeOut,
      receiveTimeout: timeOut,
      responseType: ResponseType.bytes,
      method: "get"));

  FileDownloadManager({this.storageFolder, this.listener, this.timeOut});

  void download(String url) async {
    final file = await _prepareFile(url);
    _client.download(url, file.path, onReceiveProgress: (count, total) {
      listener?.onProgressDownload?.call(count, total);
    }).then((value) {
      listener?.onSuccessDownload.call(file);
    }).catchError((e) {
      listener?.onFailedDownload?.call(e, file);
    });
  }

  Future<File> downloadAsync(String url,
      {Function(int, int)? onProgress}) async {
    final file = await _prepareFile(url);
    await _client.download(url, file.path, onReceiveProgress: onProgress);
    return file;
  }

  Future<File> _prepareFile(String url) async {
    final folder = await _storageFolder();
    final fileName = basename(url);
    final file = File("%s/%s".format([folder.path, fileName]));
    return file;
  }

  Future<Directory> _storageFolder() async {
    if (storageFolder != null) {
      bool exists = await storageFolder!.exists();
      if (!exists) {
        await storageFolder!.create(recursive: true);
      }
      return storageFolder!;
    }
    storageFolder = _defaultDirectory;
    return _storageFolder();
  }
}
