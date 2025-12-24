import 'package:geolocator/geolocator.dart';
import '../../domain/entities/user_location_entity.dart';
import '../../domain/repositories/map_repository.dart';

/// Location Service
///
/// Handles device location using Geolocator package.
/// Provides current location and location stream capabilities.
class LocationService {
  /// Get current device location
  Future<UserLocationEntity> getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    );

    return UserLocationEntity(
      latitude: position.latitude,
      longitude: position.longitude,
      accuracy: position.accuracy,
      altitude: position.altitude,
      heading: position.heading,
      speed: position.speed,
      timestamp: position.timestamp,
    );
  }

  /// Stream of location updates
  Stream<UserLocationEntity> getLocationStream() {
    return Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    ).map((position) => UserLocationEntity(
          latitude: position.latitude,
          longitude: position.longitude,
          accuracy: position.accuracy,
          altitude: position.altitude,
          heading: position.heading,
          speed: position.speed,
          timestamp: position.timestamp,
        ));
  }

  /// Check if location services are enabled
  Future<bool> isLocationServiceEnabled() async {
    return Geolocator.isLocationServiceEnabled();
  }

  /// Check location permission status
  Future<LocationPermissionStatus> checkPermission() async {
    final permission = await Geolocator.checkPermission();
    return _mapPermission(permission);
  }

  /// Request location permission
  Future<LocationPermissionStatus> requestPermission() async {
    final permission = await Geolocator.requestPermission();
    return _mapPermission(permission);
  }

  LocationPermissionStatus _mapPermission(LocationPermission permission) {
    switch (permission) {
      case LocationPermission.always:
      case LocationPermission.whileInUse:
        return LocationPermissionStatus.granted;
      case LocationPermission.denied:
        return LocationPermissionStatus.denied;
      case LocationPermission.deniedForever:
        return LocationPermissionStatus.deniedForever;
      case LocationPermission.unableToDetermine:
        return LocationPermissionStatus.unknown;
    }
  }

  /// Open app settings for permission
  Future<bool> openAppSettings() => Geolocator.openAppSettings();

  /// Open location settings
  Future<bool> openLocationSettings() => Geolocator.openLocationSettings();
}
