import 'package:get/get.dart';
import 'package:softi_packages/packages/services/device/media_picker/camera_service_interface.dart';
import 'package:softi_packages/packages/services/device/media_picker/models.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

class CameraService extends ICameraService {
  final _typeMap = <AssetType, MediaFormat>{AssetType.image: MediaFormat.image, AssetType.video: MediaFormat.video, AssetType.audio: MediaFormat.audio};

  Future<List<FileMediaAsset>> _processAssetsList(List<AssetEntity> assets) async {
    var _fileList = assets.map<Future<FileMediaAsset>>((asset) async {
      // print('SSET ID : ${asset.id}');
      return FileMediaAsset(
        file: XFile((await asset.file)!.path),

        id: asset.id,
        //source: source,
        thumbData: await asset.thumbnailDataWithSize(ThumbnailSize(200, 200)),
        format: _typeMap[asset.type],
        rawEntity: asset,
      );
    }).toList();
    return await Future.wait(_fileList);
  }

  Future<List<FileMediaAsset>?> _useCamera({
    Set<MediaFormat> formats = const {MediaFormat.image, MediaFormat.video},
  }) async {
    final _assetList = await CameraPicker.pickFromCamera(
      Get.context!,
      // onlyEnableRecording: ,
      // isOnlyAllowRecording: !formats.contains(MediaFormat.image),
      // isAllowRecording: formats.contains(MediaFormat.video),
      pickerConfig: CameraPickerConfig(
        resolutionPreset: ResolutionPreset.medium,
        textDelegate: EnglishCameraPickerTextDelegate(),
      ),
    );

    if (_assetList == null) return null;

    return _processAssetsList([_assetList]);
  }

  @override
  Future<List<FileMediaAsset>?> useCamera({Set<MediaFormat> formats = const {MediaFormat.image, MediaFormat.video}}) {
    return failureCatcher<List<FileMediaAsset>?>(() => _useCamera(formats: formats));
  }
}
