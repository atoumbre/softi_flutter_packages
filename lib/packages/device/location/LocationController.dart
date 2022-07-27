import 'package:location/location.dart';
import 'package:get/get.dart';
import 'package:softi_packages/packages/core/controllers/BaseController.dart';
import 'package:softi_packages/packages/device/location/location_service_intervace.dart';

// enum LoadingStatus { idle, loading, error }

mixin LocationControllerMixin on IBaseController {
  ILocationService locationService = Get.find<ILocationService>();

  Rxn<LocationData?> locationData = Rxn<LocationData?>();

  void initLocaltionMonitoring() {
    locationData.bindStream(locationService.locationStream);
  }
}

class LocationController extends IBaseController with LocationControllerMixin {
  @override
  final ILocationService locationService;

  LocationController(this.locationService);
}
