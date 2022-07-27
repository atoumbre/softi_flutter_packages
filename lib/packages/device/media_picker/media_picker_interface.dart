import 'package:softi_packages/packages/core/services/BaseService.dart';
import 'package:softi_packages/packages/device/media_picker/models.dart';

abstract class IMediaPicker extends IBaseService {
  Future<List<FileMediaAsset>?> selectMediaFromGallery({
    Set<MediaFormat> formats = const {MediaFormat.image, MediaFormat.video},
    List<FileMediaAsset> selectedItemId = const [],
    int? maxItem,
  });

  // Future<List<MediaAsset>?> selectMediaFromGalleryData({
  //   Set<MediaFormat> formats = const {MediaFormat.image, MediaFormat.video},
  //   List<FileMediaAsset> selectedItemId = const [],
  //   int? maxItem,
  // });

  ///
  // Future<File?> singleImageSelect({bool? crop, PickerSource? source});
}
