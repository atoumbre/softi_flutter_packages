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
  final MediaSource? source;
  final MediaFormat? format;
  final Uint8List? data;
  final Uint8List? thumbData;
  final dynamic rawEntity;

  MediaAsset({
    this.source,
    this.format,
    this.data,
    this.thumbData,
    this.rawEntity,
  });
}

class NetworkMediaAsset extends MediaAsset {
  final String? id;
  final String? url;
  final String? thumbUrl;

  NetworkMediaAsset({
    this.id,
    this.url,
    this.thumbUrl,
    super.thumbData,
    super.format,
    super.rawEntity,
  }) : super(source: MediaSource.network);
}

class FileMediaAsset extends MediaAsset {
  final String? id;
  final XFile? file;
  final XFile? thumbfile;

  FileMediaAsset({
    this.id,
    this.file,
    this.thumbfile,
    super.thumbData,
    super.format,
    super.rawEntity,
  }) : super(source: MediaSource.file);
}
