import 'package:softi_packages/packages/core/services/BaseService.dart';
import 'package:softi_packages/packages/services/device/media_picker/models.dart';

abstract class ICameraService extends IBaseService {
  Future<List<FileMediaAsset>?> useCamera({
    Set<MediaFormat> formats = const {MediaFormat.image, MediaFormat.video},
  });
}
