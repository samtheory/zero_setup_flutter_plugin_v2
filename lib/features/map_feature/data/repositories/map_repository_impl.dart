import 'package:latlong2/latlong.dart';
import '../../domain/entities/poi_entity.dart';
import '../../domain/entities/user_location_entity.dart';
import '../../domain/repositories/map_repository.dart';
import '../datasources/location_service.dart';
import '../datasources/poi_local_datasource.dart';

/// Map Repository Implementation
///
/// Combines location service and POI datasource to provide
/// all map-related functionality.
class MapRepositoryImpl implements MapRepository {
  final LocationService _locationService;
  final PoiLocalDatasource _poiDatasource;

  MapRepositoryImpl({required LocationService locationService, required PoiLocalDatasource poiDatasource})
    : _locationService = locationService,
      _poiDatasource = poiDatasource;

  @override
  Future<UserLocationEntity> getCurrentLocation() => _locationService.getCurrentLocation();

  @override
  Stream<UserLocationEntity> getLocationStream() => _locationService.getLocationStream();

  @override
  Future<List<PoiEntity>> getAllPois() => _poiDatasource.getAllPois();

  @override
  Future<List<PoiEntity>> getPoisInRadius(LatLng center, double radiusMeters) =>
      _poiDatasource.getPoisInRadius(center, radiusMeters);

  @override
  Future<List<PoiEntity>> getPoisByCategory(PoiCategory category) => _poiDatasource.getPoisByCategory(category);

  @override
  Future<PoiEntity?> getPoiById(String id) => _poiDatasource.getPoiById(id);

  @override
  Future<List<PoiEntity>> searchPois(String query) => _poiDatasource.searchPois(query);

  @override
  Future<void> addPoi(PoiEntity poi) => _poiDatasource.addPoi(poi);

  @override
  Future<bool> isLocationServiceEnabled() => _locationService.isLocationServiceEnabled();

  @override
  Future<LocationPermissionStatus> checkLocationPermission() => _locationService.checkPermission();

  @override
  Future<LocationPermissionStatus> requestLocationPermission() => _locationService.requestPermission();
}
