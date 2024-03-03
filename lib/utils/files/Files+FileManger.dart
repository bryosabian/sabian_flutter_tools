import 'dart:io';

import 'package:sabian_tools/utils/files/FileManager.dart';

extension FileOperations on File {
  Future<File> copyToDir(Directory directory,
      {bool checkIfExists = true, bool createDirIfDoesNotExist = true}) async {
    FileManager manager = FileManager();
    return manager.copyFileToDir(this, directory,
        checkIfExists: checkIfExists,
        createDirIfDoesNotExist: createDirIfDoesNotExist);
  }

  Future<File> moveToDir(Directory directory,
      {bool checkIfExists = true, bool createDirIfDoesNotExist = true}) {
    FileManager manager = FileManager();
    return manager.moveFileToDir(this, directory,
        checkIfExists: checkIfExists,
        createDirIfDoesNotExist: createDirIfDoesNotExist);
  }
}
