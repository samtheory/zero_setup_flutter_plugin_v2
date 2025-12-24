import 'package:latlong2/latlong.dart';
import '../../domain/entities/poi_entity.dart';

/// POI Local Data Source
///
/// Provides sample POI data for demonstration.
/// In production, this would fetch from an API or local database.
class PoiLocalDatasource {
  /// Sample POI data (Tehran landmarks)
  static final List<PoiEntity> _samplePois = [
    const PoiEntity(
      id: '1',
      name: 'Azadi Tower',
      description: 'Famous landmark and symbol of Tehran',
      latitude: 35.6997,
      longitude: 51.3380,
      category: PoiCategory.tourism,
    ),
    const PoiEntity(
      id: '2',
      name: 'Milad Tower',
      description: 'Tallest tower in Iran',
      latitude: 35.7448,
      longitude: 51.3753,
      category: PoiCategory.tourism,
    ),
    const PoiEntity(
      id: '3',
      name: 'Grand Bazaar',
      description: 'Historic market and trading center',
      latitude: 35.6713,
      longitude: 51.4217,
      category: PoiCategory.shopping,
    ),
    const PoiEntity(
      id: '4',
      name: 'Golestan Palace',
      description: 'UNESCO World Heritage Site',
      latitude: 35.6833,
      longitude: 51.4167,
      category: PoiCategory.tourism,
    ),
    const PoiEntity(
      id: '5',
      name: 'Tehran Metro Station',
      description: 'Central metro hub',
      latitude: 35.6892,
      longitude: 51.3890,
      category: PoiCategory.transportation,
    ),
    const PoiEntity(
      id: '6',
      name: 'City Park Coffee',
      description: 'Popular cafe in the city center',
      latitude: 35.6950,
      longitude: 51.4100,
      category: PoiCategory.food,
    ),
    const PoiEntity(
      id: '7',
      name: 'Central Hospital',
      description: 'Major medical center',
      latitude: 35.7100,
      longitude: 51.4000,
      category: PoiCategory.health,
    ),
    const PoiEntity(
      id: '8',
      name: 'Tehran University',
      description: 'Largest university in Iran',
      latitude: 35.7022,
      longitude: 51.3950,
      category: PoiCategory.education,
    ),
    const PoiEntity(
      id: '9',
      name: 'Cinema City',
      description: 'Entertainment complex',
      latitude: 35.7200,
      longitude: 51.4200,
      category: PoiCategory.entertainment,
    ),
    const PoiEntity(
      id: '10',
      name: 'Central Parking',
      description: 'Large parking facility',
      latitude: 35.6850,
      longitude: 51.3950,
      category: PoiCategory.parking,
    ),
  ];

  final List<PoiEntity> _pois = List.from(_samplePois);

  /// Get all POIs
  Future<List<PoiEntity>> getAllPois() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    return _pois;
  }

  /// Get POIs within radius
  Future<List<PoiEntity>> getPoisInRadius(LatLng center, double radiusMeters) async {
    await Future.delayed(const Duration(milliseconds: 200));
    const distance = Distance();

    return _pois.where((poi) {
      final distanceToCenter = distance.as(
        LengthUnit.Meter,
        center,
        poi.latLng,
      );
      return distanceToCenter <= radiusMeters;
    }).toList();
  }

  /// Get POIs by category
  Future<List<PoiEntity>> getPoisByCategory(PoiCategory category) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _pois.where((poi) => poi.category == category).toList();
  }

  /// Get POI by ID
  Future<PoiEntity?> getPoiById(String id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    try {
      return _pois.firstWhere((poi) => poi.id == id);
    } catch (_) {
      return null;
    }
  }

  /// Search POIs by name
  Future<List<PoiEntity>> searchPois(String query) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final lowercaseQuery = query.toLowerCase();
    return _pois.where((poi) {
      return poi.name.toLowerCase().contains(lowercaseQuery) ||
          (poi.description?.toLowerCase().contains(lowercaseQuery) ?? false);
    }).toList();
  }

  /// Add a new POI
  Future<void> addPoi(PoiEntity poi) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _pois.add(poi);
  }
}
