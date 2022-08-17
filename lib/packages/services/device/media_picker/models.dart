// import 'dart:io';
import 'dart:typed_data';

import 'package:wechat_camera_picker/wechat_camera_picker.dart';

enum ImageSource {
  /// Opens up the device camera, letting the user to take a new picture.
  camera,

  /// Opens the user's photo gallery.
  gallery,
}

enum MediaFormat { image, video, audio }

enum MediaSource { file, network, memory }

enum PickerSource { camera, gallery, file }

class MediaAsset {
  final dynamic rawEntity;
  final Uint8List? data;
  final MediaFormat? format;
  final MediaSource? source;
  final Uint8List? thumbData;

  MediaAsset({
    this.thumbData,
    this.source,
    this.format,
    this.data,
    this.rawEntity,
  });
}

// class MemoryMediaAsset extends MediaAsset {
//   final Uint8List? data;

//   MemoryMediaAsset({
//     this.data,
//     MediaFormat? format,
//     Uint8List? thumbData,
//     rawEntity,
//   }) : super(
//           thumbData: thumbData,
//           rawEntity: rawEntity,
//           format: format,
//           source: MediaSource.memory,
//         );
// }

class NetworkMediaAsset extends MediaAsset {
  final String? title;
  final String? url;

  NetworkMediaAsset({
    this.title,
    this.url,
    MediaFormat? format,
    Uint8List? thumbData,
    rawEntity,
  }) : super(thumbData: thumbData, rawEntity: rawEntity, format: format, source: MediaSource.network);
}

class FileMediaAsset extends MediaAsset {
  final String? id;
  final XFile? file;

  FileMediaAsset({
    this.id,
    this.file,
    thumbData,
    format,
    rawEntity,
  }) : super(
          thumbData: thumbData,
          rawEntity: rawEntity,
          format: format,
        );
}
