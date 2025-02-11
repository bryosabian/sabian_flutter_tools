import 'dart:convert';
import 'dart:io';

extension FileSabianExtension on File {
  Future<String> toBase64() async {
    final bytes = await readAsBytes();
    final encoded = base64Encode(bytes);
    return encoded;
  }

  Future<String?> toBase64OrNull() async {
    try {
      return toBase64();
    } catch (_) {
      return null;
    }
  }

  String get fileName {
    return path
        .split('/')
        .last;
  }

  String get completePath {
    return path;
  }
}

extension FileStringExtension on String {
  File get toFile => File(this);
}
