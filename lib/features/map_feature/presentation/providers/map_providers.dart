import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../data/datasources/location_service.dart';
import '../../data/datasources/poi_local_datasource.dart';
import '../../data/repositories/map_repository_impl.dart';
import '../../domain/repositories/map_repository.dart';
import '../../domain/usecases/get_location_usecase.dart';
import '../../domain/usecases/get_pois_usecase.dart';

// ════════════════════════════════════════════════════════════════════════════
// Data Sources
// ════════════════════════════════════════════════════════════════════════════

/// Location Service Provider
final locationServiceProvider = Provider<LocationService>((ref) {
  return LocationService();
});

/// POI Datasource Provider
final poiDatasourceProvider = Provider<PoiLocalDatasource>((ref) {
  return PoiLocalDatasource();
});

// ════════════════════════════════════════════════════════════════════════════
// Repository
// ════════════════════════════════════════════════════════════════════════════

/// Map Repository Provider
final mapRepositoryProvider = Provider<MapRepository>((ref) {
  return MapRepositoryImpl(
    locationService: ref.watch(locationServiceProvider),
    poiDatasource: ref.watch(poiDatasourceProvider),
  );
});

// ════════════════════════════════════════════════════════════════════════════
// Use Cases
// ════════════════════════════════════════════════════════════════════════════

/// Get Current Location Use Case Provider
final getCurrentLocationUseCaseProvider = Provider<GetCurrentLocationUseCase>((ref) {
  return GetCurrentLocationUseCase(ref.watch(mapRepositoryProvider));
});

/// Get Location Stream Use Case Provider
final getLocationStreamUseCaseProvider = Provider<GetLocationStreamUseCase>((ref) {
  return GetLocationStreamUseCase(ref.watch(mapRepositoryProvider));
});

/// Get All POIs Use Case Provider
final getAllPoisUseCaseProvider = Provider<GetAllPoisUseCase>((ref) {
  return GetAllPoisUseCase(ref.watch(mapRepositoryProvider));
});

/// Get POIs In Radius Use Case Provider
final getPoisInRadiusUseCaseProvider = Provider<GetPoisInRadiusUseCase>((ref) {
  return GetPoisInRadiusUseCase(ref.watch(mapRepositoryProvider));
});

/// Get POIs By Category Use Case Provider
final getPoisByCategoryUseCaseProvider = Provider<GetPoisByCategoryUseCase>((ref) {
  return GetPoisByCategoryUseCase(ref.watch(mapRepositoryProvider));
});

/// Search POIs Use Case Provider
final searchPoisUseCaseProvider = Provider<SearchPoisUseCase>((ref) {
  return SearchPoisUseCase(ref.watch(mapRepositoryProvider));
});
