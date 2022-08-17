import 'package:location/location.dart';
import 'package:softi_packages/packages/core/services/SoppableService.dart';

abstract class ILocationService extends IStoppableService {
  Stream<LocationData?> get locationStream;
  Future<LocationData?> getLocation();
}
