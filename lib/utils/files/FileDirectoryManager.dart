import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sabian_tools/extensions/Strings+Sabian.dart';

import 'FileManager.dart';

class FileDirectoryManager {
  late FileManager _fileManager;
  Directory? storageDirectory;
  String? defaultDirectoryName;

  FileDirectoryManager({this.storageDirectory, FileManager? fileManager}) {
    _fileManager = fileManager ?? FileManager();
  }

  Future<Directory> getStorageDirectory(String? subDirectoryName,
      {bool createIfNotExist = true}) async {
    if (storageDirectory != null && createIfNotExist) {
      if (await storageDirectory!.exists() != true) {
        storageDirectory = await storageDirectory!.create(recursive: true);
      }
    }

    Directory directory = storageDirectory ??
        await getDefaultStorageDirectory(createIfNotExist: createIfNotExist);
    if (subDirectoryName != null && subDirectoryName.isNotBlankOrEmpty) {
      directory = Directory("%s/%s".format([directory.path, subDirectoryName]));
      if (createIfNotExist) {
        bool exists = await directory.exists();
        if (!exists) {
          directory = await directory.create(recursive: true);
        }
      }
    }
    return directory;
  }

  @protected
  Future<Directory> getDefaultStorageDirectory(
      {bool createIfNotExist = true}) async {
    final Directory appDir = await getApplicationDocumentsDirectory();
    String? dirName = defaultDirectoryName;
    if (dirName == null || dirName.isBlankOrEmpty) {
      final platform = await PackageInfo.fromPlatform();
      dirName = platform.appName.ifEmpty(() => "SabianFiles");
    }
    final Directory dir = Directory("%s/%s".format([appDir.path, dirName]));
    if (createIfNotExist) {
      bool exists = await dir.exists();
      if (!exists) {
        await dir.create(recursive: true);
      }
    }
    return dir;
  }

  ///Stores a temporary file to a permanent one
  Future<File> storeTempFile(File tempFile,
      {String? subDirectoryName,
      bool createDirIfNotFound = true,
      bool deleteAfter = true}) async {
    Directory storageDirectory = await getStorageDirectory(subDirectoryName,
        createIfNotExist: createDirIfNotFound);
    File newFile = await _fileManager.copyFileToDir(tempFile, storageDirectory,
        checkIfExists: true,
        createDirIfDoesNotExist: createDirIfNotFound,
        deleteAfter: deleteAfter);
    return newFile;
  }

  ///Creates a file from bytes
  Future<File> createFileFromBytes(Uint8List data, String fileName,
      {String? subDirectoryName, bool createDirIfNotFound = true}) async {
    Directory storageDirectory = await getStorageDirectory(subDirectoryName,
        createIfNotExist: createDirIfNotFound);
    File newFile = await _fileManager.writeToFile(data, fileName,
        folder: storageDirectory,
        checkIfDirExists: createDirIfNotFound,
        createDirIfDoesNotExist: createDirIfNotFound);
    return newFile;
  }

  ///Creates a file from bytes
  Future<File> createFileFromContent(String content, String fileName,
      {String? subDirectoryName, bool createDirIfNotFound = true}) async {
    Directory storageDirectory = await getStorageDirectory(subDirectoryName,
        createIfNotExist: createDirIfNotFound);
    File newFile = await _fileManager.writeContentToFile(content, fileName,
        folder: storageDirectory,
        checkIfDirExists: createDirIfNotFound,
        createDirIfDoesNotExist: createDirIfNotFound);
    return newFile;
  }

  ///Deletes file and returns the deleted file information. Throws an exception if file does not exist or error occurred
  ///Use [deleteFileOrNull] to return null if file does not exist or an exception occurred
  Future<FileSystemEntity> deleteFile(File file) async {
    final deleted = await file.delete();
    return deleted;
  }

  ///Deletes file and returns deleted file information or null if file does not exist or an exception occurred
  Future<FileSystemEntity?> deleteFileOrNull(File file) async {
    try {
      final deleted = await deleteFile(file);
      return deleted;
    } catch (e) {
      return null;
    }
  }
}
