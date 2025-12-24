import 'package:latlong2/latlong.dart';

/// Point of Interest Entity
///
/// Represents a location point on the map with metadata.
/// Used for markers, destinations, and other map annotations.
///
/// **Example:**
/// ```dart
/// final poi = PoiEntity(
///   id: '1',
///   name: 'Coffee Shop',
///   latitude: 35.6892,
///   longitude: 51.3890,
///   category: PoiCategory.food,
/// );
/// ```
class PoiEntity {
  final String id;
  final String name;
  final String? description;
  final double latitude;
  final double longitude;
  final PoiCategory category;
  final String? imageUrl;
  final Map<String, dynamic>? metadata;

  const PoiEntity({
    required this.id,
    required this.name,
    this.description,
    required this.latitude,
    required this.longitude,
    this.category = PoiCategory.general,
    this.imageUrl,
    this.metadata,
  });

  /// Get LatLng for flutter_map
  LatLng get latLng => LatLng(latitude, longitude);

  /// Calculate distance to another point (in meters)
  double distanceTo(PoiEntity other) {
    const distance = Distance();
    return distance.as(LengthUnit.Meter, latLng, other.latLng);
  }

  /// Calculate distance from current location
  double distanceFrom(LatLng currentLocation) {
    const distance = Distance();
    return distance.as(LengthUnit.Meter, currentLocation, latLng);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is PoiEntity && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'PoiEntity(id: $id, name: $name, lat: $latitude, lng: $longitude)';
}

/// Categories for POI markers
enum PoiCategory {
  general,
  food,
  shopping,
  transportation,
  health,
  education,
  entertainment,
  tourism,
  service,
  parking,
}

/// Extension for category display
extension PoiCategoryX on PoiCategory {
  String get displayName {
    switch (this) {
      case PoiCategory.general:
        return 'General';
      case PoiCategory.food:
        return 'Food & Drink';
      case PoiCategory.shopping:
        return 'Shopping';
      case PoiCategory.transportation:
        return 'Transportation';
      case PoiCategory.health:
        return 'Health';
      case PoiCategory.education:
        return 'Education';
      case PoiCategory.entertainment:
        return 'Entertainment';
      case PoiCategory.tourism:
        return 'Tourism';
      case PoiCategory.service:
        return 'Service';
      case PoiCategory.parking:
        return 'Parking';
    }
  }

  String get icon {
    switch (this) {
      case PoiCategory.general:
        return '📍';
      case PoiCategory.food:
        return '🍽️';
      case PoiCategory.shopping:
        return '🛒';
      case PoiCategory.transportation:
        return '🚌';
      case PoiCategory.health:
        return '🏥';
      case PoiCategory.education:
        return '🎓';
      case PoiCategory.entertainment:
        return '🎭';
      case PoiCategory.tourism:
        return '🏛️';
      case PoiCategory.service:
        return '🔧';
      case PoiCategory.parking:
        return '🅿️';
    }
  }
}
