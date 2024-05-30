import 'dart:io';

class FileDownloadListener {
  Function()? onBeforeDownload;
  final Function(File file) onSuccessDownload;
  Function(Exception, File?)? onFailedDownload;
  Function(int, int)? onProgressDownload;

  FileDownloadListener({
    this.onBeforeDownload,
    required this.onSuccessDownload,
    this.onFailedDownload,
    this.onProgressDownload,
  });
}
