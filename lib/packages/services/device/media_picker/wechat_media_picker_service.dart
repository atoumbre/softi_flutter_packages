import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:softi_packages/packages/services/device/media_picker/interfaces/media_picker_interface.dart';
import 'package:softi_packages/packages/services/device/media_picker/models.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

class WechatMediaPicker extends IMediaPicker {
  final _requestTypeMapper = <Set<MediaFormat>, RequestType>{
    {MediaFormat.audio}: RequestType.audio,
    {MediaFormat.video}: RequestType.video,
    {MediaFormat.image}: RequestType.image,
    {MediaFormat.image, MediaFormat.video}: RequestType.common,
    {MediaFormat.audio, MediaFormat.video, MediaFormat.image}: RequestType.all,
    {MediaFormat.audio, MediaFormat.video}: RequestType.video,
    {MediaFormat.audio, MediaFormat.image}: RequestType.image,
  };

  final _typeMap = <AssetType, MediaFormat>{AssetType.image: MediaFormat.image, AssetType.video: MediaFormat.video, AssetType.audio: MediaFormat.audio};

  // final _pickerSourceMap = <PickerSource, ImageSource>{PickerSource.camera: ImageSource.camera, PickerSource.gallery: ImageSource.gallery, PickerSource.file: ImageSource.gallery};

  Future<List<FileMediaAsset>> _processAssetsList(List<AssetEntity> assets) async {
    var crop = assets.length == 1;

    var _fileList = assets.map<Future<FileMediaAsset>>((asset) async {
      print('SSET ID : ${asset.id}');

      var _file = await asset.file;

      if (crop && _file != null) {
        var _croppfile = await _cropImage(_file);
        _file = _croppfile?.path != null ? File(_croppfile!.path) : _file;
      }

      return FileMediaAsset(
        file: XFile(_file?.path ?? ''),

        id: asset.id,
        //source: source,
        thumbData: await asset.thumbnailDataWithSize(ThumbnailSize.square(200)),
        format: _typeMap[asset.type],
        rawEntity: asset,
      );
    }).toList();
    return await Future.wait(_fileList);
  }

  // @override
  // Future<List<FileMediaAsset>> selectMediaFromCamera({
  //   Set<MediaFormat> formats = const {MediaFormat.image, MediaFormat.video},
  // }) async {
  //   final _assetList = await CameraPicker.pickFromCamera(
  //     Get.context,
  //     isOnlyAllowRecording: !formats.contains(MediaFormat.image),
  //     isAllowRecording: formats.contains(MediaFormat.video),
  //     resolutionPreset: ResolutionPreset.medium,
  //     textDelegate: EnglishCameraPickerTextDelegate(),
  //   );

  //   if (_assetList == null) return null;

  //   return _processAssetsList([_assetList]);
  // }

  @override
  Future<List<FileMediaAsset>?> selectMediaFromGallery({
    Set<MediaFormat> formats = const {MediaFormat.image, MediaFormat.video},
    List<FileMediaAsset> selectedItemId = const [],
    int? maxItem = 1,
  }) async {
    var _lastSelection = await Future.wait(selectedItemId.map((e) => AssetEntity.fromId(e.id!)).toList());
    var __lastSelection = <AssetEntity>[];

    _lastSelection.forEach((element) {
      if (element != null) __lastSelection.add(element);
    });

    var _requestType = _requestTypeMapper[formats] ?? RequestType.common;
    final _assetList = await AssetPicker.pickAssets(
      Get.context!,
      pickerConfig: AssetPickerConfig(
        requestType: _requestType,
        selectedAssets: __lastSelection,
        textDelegate: EnglishAssetPickerTextDelegate(),
        maxAssets: maxItem!,
      ),
    );

    if (_assetList == null) return null;

    var result = await _processAssetsList(_assetList);

    return result;
  }

  // @override
  // Future<File?> singleImageSelect({PickerSource? source = PickerSource.gallery, bool? crop}) async {
  //   final _picker = ImagePicker();

  //   File? response;

  //   final _picked = await _picker.pickImage(source: _pickerSourceMap[source!]!);
  //   if (_picked != null) {
  //     response = File(_picked.path);
  //     response = crop! ? await (_cropImage(response) as FutureOr<File>) : response;
  //   }

  //   return response;
  // }

  Future<CroppedFile?> _cropImage(File imageFile) async {
    var croppedFile = await ImageCropper().cropImage(
        maxWidth: 640,
        sourcePath: imageFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [CropAspectRatioPreset.square, CropAspectRatioPreset.ratio3x2, CropAspectRatioPreset.original, CropAspectRatioPreset.ratio4x3, CropAspectRatioPreset.ratio16x9]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            title: 'Cropper',
          )
        ]);

    return croppedFile;
    // if (croppedFile != null) {
    //   imageFile = croppedFile;
    //   setState(() {
    //     state = AppState.cropped;
    //   });
    // }
  }
}
