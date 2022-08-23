import 'dart:async';
import 'dart:typed_data';
import 'package:path/path.dart' as p;
import 'package:softi_packages/packages/core/services/BaseService.dart';

enum UploadState {
  running,
  error,
  paused,
  canceled,
  success,
}

class RemoteAsset {
  // final String? title;
  final String identifier;
  final String folder;
  final String url;
  final String thumbUrl;

  const RemoteAsset({
    // this.title,
    required this.identifier,
    required this.folder,
    required this.url,
    required this.thumbUrl,
  });

  String get fullPath => p.join(folder, identifier);

  static RemoteAsset fromJson(Map<String, dynamic> json) => RemoteAsset(
        // title: json['title'] as String? ?? '',
        identifier: json['identifier'] as String? ?? '',
        folder: json['folder'] as String? ?? '',
        url: json['url'] as String? ?? '',
        thumbUrl: json['thumbUrl'] as String? ?? '',
      );

  Map<String, dynamic> toJson() {
    var instance = this;
    // 'title': instance.title,
    return <String, dynamic>{
      'identifier': instance.identifier,
      'folder': instance.folder,
      'url': instance.url,
      'thumbUrl': instance.thumbUrl,
    };
  }
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
  Future<Stream<UploadEvent>> uploadMediaService({
    required Uint8List imageToUpload,
    required String folder,
    required String identifier,
    required bool compressed,
    required String localIdentifier,
  });

  Future<UploadEvent> uploadMedia({
    required Uint8List imageToUpload,
    required String folder,
    required String identifier,
    required bool compressed,
    required String localIdentifier,
  }) {
    return failureCatcher<UploadEvent>(() async {
      return (await uploadMediaService(
        compressed: compressed,
        folder: folder,
        imageToUpload: imageToUpload,
        identifier: identifier,
        localIdentifier: localIdentifier,
      ))
          .last;
    });
  }

  Future<Stream<UploadEvent>> uploadMediaStream({
    required Uint8List imageToUpload,
    required String forlder,
    required bool compressed,
    required String identifier,
    required String localIdentifier,
  }) {
    return failureCatcher<Stream<UploadEvent>>(() {
      return uploadMediaService(
        compressed: compressed,
        folder: forlder,
        imageToUpload: imageToUpload,
        identifier: identifier,
        localIdentifier: localIdentifier,
      );
    });
  }

  Future<void> deleteMedia(RemoteAsset remoteAsset);

  // Future<UploadEvent> uploadMedia({
  //   required Uint8List imageToUpload,
  //   required String folder,
  //   required bool compressed,
  // });

  // Future<Stream<UploadEvent>> uploadMediaStream({
  //   required Uint8List imageToUpload,
  //   required String title,
  //   required bool compressed,
  // });

  // Future<Stream<UploadEvent>> uploadMediaFile({
  //   required File imageToUpload,
  //   required String folder,
  //   required bool compressed,
  // });

  // Future<Stream<UploadEvent>> uploadMediaBytes({
  //   required Uint8List imageToUpload,
  //   required String folder,
  //   required bool compressed,
  // });

  // Future<Stream<UploadEvent>> uploadMediaUrl({
  //   required String url,
  //   required String folder,
  //   required bool compressed,
  // });

}
