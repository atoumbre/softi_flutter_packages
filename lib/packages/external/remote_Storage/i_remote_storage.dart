import 'dart:typed_data';

import 'package:softi_packages/packages/core/services/BaseService.dart';

enum UploadState {
  running,
  paused,
  canceled,
  error,
  success,
}

class RemoteAsset {
  final String? title;
  final String? url;

  RemoteAsset({
    this.title,
    this.url,
  });
}

class UploadEvent {
  final UploadState? type;
  final double? uploaded;
  final double? total;

  final dynamic rawrResult;

  final RemoteAsset? result;

  UploadEvent({this.rawrResult, this.result, this.type, this.uploaded, this.total});

  double get progress => (total != 0 && uploaded != null) ? uploaded! / total! : 0;
}

abstract class IRemoteStorageService extends IBaseService {
  Future<UploadEvent> uploadMedia({
    required Uint8List imageToUpload,
    required String title,
    required bool compressed,
  });

  Future<Stream<UploadEvent>> uploadMediaStream({
    required Uint8List imageToUpload,
    required String title,
    required bool compressed,
  });

  Future<void> deleteMedia(String imageFileName);
}
