import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart';
import 'package:sabian_tools/extensions/Strings+Sabian.dart';
import 'package:sabian_tools/utils/utils.dart';

class FileManager {
  Future<File> copyFileToDir(File file, Directory destination,
      {bool checkIfExists = true,
      bool createDirIfDoesNotExist = true,
      bool deleteAfter = false}) async {
    bool exists = true;

    if (checkIfExists) {
      exists = await file.exists();
      if (!exists) {
        throw Exception("File does not exist");
      }
      exists = await destination.exists();
      if (!exists) {
        if (!createDirIfDoesNotExist) {
          throw Exception("Directory does not exist");
        } else {
          destination = await destination.create(recursive: true);
        }
      }
    }

    String fileName = basename(file.path);
    String destPath = "%s/%s".format([destination.path, fileName]);
    File newFile = await file.copy(destPath);
    if (deleteAfter) {
      final deleted = await file.delete();
      sabianPrint(deleted.path);
    }
    return newFile;
  }

  Future<File> moveFileToDir(File file, Directory destination,
      {bool checkIfExists = true, bool createDirIfDoesNotExist = false}) {
    return copyFileToDir(file, destination,
        checkIfExists: checkIfExists,
        createDirIfDoesNotExist: createDirIfDoesNotExist,
        deleteAfter: true);
  }

  ///Writes bytes to a file
  /// [fileName] must have the extension too
  /// [folder] the full path of the parent folder
  ///
  Future<File> writeToFile(List<int> data, String fileName,
      {Directory? folder,
      bool checkIfDirExists = true,
      bool createDirIfDoesNotExist = true}) async {
    bool exists = true;

    if (checkIfDirExists && folder != null) {
      exists = await folder.exists();
      if (!exists) {
        if (!createDirIfDoesNotExist) {
          throw Exception("Directory does not exist");
        } else {
          folder = await folder.create(recursive: true);
        }
      }
    }

    String destPath =
        (folder != null) ? "%s/%s".format([folder.path, fileName]) : fileName;
    File newFile = await File(destPath).create(recursive: true);
    newFile = await newFile.writeAsBytes(data, flush: true);
    return newFile;
  }
}
