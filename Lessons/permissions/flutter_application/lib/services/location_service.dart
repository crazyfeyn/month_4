import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationService {
  static final _location = Location();
  static PermissionStatus permissionStatus = PermissionStatus.denied;
  static bool _isServiceEnabled = false;
  static LocationData? currentLocation;

  static Future<void> init() async {
    await _checkService();
    await checkPermission();
    await getCurrentLocation();

    await _location.changeSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
      interval: 1000,
    );
  }

  //gps yoqilganmi tekshiramiz
  static Future<void> _checkService() async {
    _isServiceEnabled = await _location.serviceEnabled();
    if (!_isServiceEnabled) {
      _isServiceEnabled = await _location.requestService();
      if (!_isServiceEnabled) {
        return; //Redirect to settings - sonzlamalardan so'rash kerak endi
      }
    }
  }

  // joylashuvni olish uchun permission berilganmi tekshiramiz
  static Future<void> checkPermission() async {
    permissionStatus = await _location.hasPermission();

    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await _location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) {
        return; //sozlamalardan to'g'irlash kerak (ruxsat so'rash kerak)
      }
    }
  }

  static Future<void> getCurrentLocation() async {
    await _checkService();
    await checkPermission();
    if (_isServiceEnabled && permissionStatus == PermissionStatus.granted) {
      currentLocation = await _location.getLocation();
    }
  }

  static Stream<LocationData> getLiveLocation() async* {
    yield* _location.onLocationChanged;
  }

  static Future<List<LatLng>> fetchPolylinePoints(
      LatLng from, LatLng to, String transportOption) async {
    final polylinePoints = PolylinePoints();

    TravelMode travelMode;
    switch (transportOption) {
      case 'walking':
        travelMode = TravelMode.walking;
        break;
      case 'bicycling':
        travelMode = TravelMode.bicycling;
        break;
      case 'transit':
        travelMode = TravelMode.transit;
        break;
      case 'driving':
      default:
        travelMode = TravelMode.driving;
        break;
    }

    var result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: "AIzaSyBEjfX9jrWudgRcWl2scld4R7s0LtlaQmQ",
      request: PolylineRequest(
        origin: PointLatLng(from.latitude, from.longitude),
        destination: PointLatLng(to.latitude, to.longitude),
        mode: travelMode,
      ),
    );

    if (result.points.isNotEmpty) {
      return result.points
          .map((point) => LatLng(point.latitude, point.longitude))
          .toList();
    }
    return [];
  }
}
