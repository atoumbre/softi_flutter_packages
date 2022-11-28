// import 'dart:async';

// import 'package:get/get.dart';
// import 'package:location/location.dart';
// import 'package:softi_packages/packages/services/device/location/location_service_intervace.dart';

// class LocationService extends ILocationService {
//   // Location Available
//   bool? locationAvailable;
//   late Rxn<LocationData> _locationStream; //= StreamController<UserLocation>.broadcast();

//   Location location = Location();

//   @override
//   Stream<LocationData?> get locationStream => _locationStream.stream;

//   @override
//   Future<LocationData?> getLocation() async {
//     var granted = await location.requestPermission();

//     if (granted == PermissionStatus.granted) {
//       return location.getLocation();
//     } else {
//       return LocationData.fromMap({});
//     }
//   }

//   @override
//   Future<void> startCallback() async {
//     _locationStream = Rxn<LocationData>();

//     var granted = await location.requestPermission();

//     _locationStream
//       ..bindStream(location.onLocationChanged)
//       ..listen((data) => print('New location ${data.toString()}'));

//     if (granted == PermissionStatus.granted) {
//       locationAvailable = true;
//     } else {
//       locationAvailable = false;
//     }
//   }

//   @override
//   Future<void> stopCallback() async {
//     _locationStream.close();
//   }
// }
