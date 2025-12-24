import 'package:latlong2/latlong.dart';

/// User Location Entity
///
/// Represents the user's current geographic location with accuracy info.
class UserLocationEntity {
  final double latitude;
  final double longitude;
  final double? accuracy;
  final double? altitude;
  final double? heading;
  final double? speed;
  final DateTime timestamp;

  const UserLocationEntity({
    required this.latitude,
    required this.longitude,
    this.accuracy,
    this.altitude,
    this.heading,
    this.speed,
    required this.timestamp,
  });

  /// Get LatLng for flutter_map
  LatLng get latLng => LatLng(latitude, longitude);

  /// Check if location is accurate enough for navigation
  bool get isAccurate => accuracy != null && accuracy! < 50;

  /// Check if user is moving
  bool get isMoving => speed != null && speed! > 0.5;

  @override
  String toString() =>
      'UserLocation(lat: $latitude, lng: $longitude, accuracy: $accuracy)';
}
