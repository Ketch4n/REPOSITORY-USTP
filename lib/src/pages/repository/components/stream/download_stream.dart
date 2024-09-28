import 'dart:async';

import 'package:repository_ustp/src/pages/repository/components/functions/download_function.dart';
import 'package:repository_ustp/src/pages/repository/components/model/download_model.dart';

class DownloadStream {
  final StreamController<List<Download>> _controller =
      StreamController<List<Download>>();

  Stream<List<Download>> get stream => _controller.stream;

  void fetchDownloads(id) async {
    List<Download> downloads = await DownloadFunction.fetchDownloads(id);
    _controller.add(downloads);
  }

  void dispose() {
    _controller.close();
  }
}
