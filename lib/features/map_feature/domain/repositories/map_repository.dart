import 'package:latlong2/latlong.dart';
import '../entities/poi_entity.dart';
import '../entities/user_location_entity.dart';

/// Map Repository Interface
///
/// Defines the contract for map-related data operations.
/// Implementations can use different data sources (API, local DB, etc.)
abstract class MapRepository {
  /// Get user's current location
  Future<UserLocationEntity> getCurrentLocation();

  /// Stream of user location updates
  Stream<UserLocationEntity> getLocationStream();

  /// Get all POIs
  Future<List<PoiEntity>> getAllPois();

  /// Get POIs within a radius (in meters)
  Future<List<PoiEntity>> getPoisInRadius(LatLng center, double radiusMeters);

  /// Get POIs by category
  Future<List<PoiEntity>> getPoisByCategory(PoiCategory category);

  /// Get a single POI by ID
  Future<PoiEntity?> getPoiById(String id);

  /// Search POIs by name
  Future<List<PoiEntity>> searchPois(String query);

  /// Add a new POI (for user-generated content)
  Future<void> addPoi(PoiEntity poi);

  /// Check if location services are enabled
  Future<bool> isLocationServiceEnabled();

  /// Check location permission status
  Future<LocationPermissionStatus> checkLocationPermission();

  /// Request location permission
  Future<LocationPermissionStatus> requestLocationPermission();
}

/// Location permission status
enum LocationPermissionStatus { granted, denied, deniedForever, restricted, unknown }
