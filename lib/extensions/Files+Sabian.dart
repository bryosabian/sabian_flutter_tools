import 'dart:convert';
import 'dart:io';

extension FileSabianExtension on File {
  Future<String> toBase64() async {
    final bytes = await readAsBytes();
    final encoded = base64Encode(bytes);
    return encoded;
  }
}
