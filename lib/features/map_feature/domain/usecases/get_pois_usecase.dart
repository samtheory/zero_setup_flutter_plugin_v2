import 'package:latlong2/latlong.dart';
import '../entities/poi_entity.dart';
import '../repositories/map_repository.dart';

/// Get All POIs Use Case
class GetAllPoisUseCase {
  final MapRepository _repository;

  GetAllPoisUseCase(this._repository);

  Future<List<PoiEntity>> call() => _repository.getAllPois();
}

/// Get POIs In Radius Use Case
///
/// Retrieves POIs within a specified radius from a center point.
///
/// **Usage:**
/// ```dart
/// final useCase = GetPoisInRadiusUseCase(repository);
/// final nearbyPois = await useCase(
///   center: LatLng(35.6892, 51.3890),
///   radiusMeters: 1000,
/// );
/// ```
class GetPoisInRadiusUseCase {
  final MapRepository _repository;

  GetPoisInRadiusUseCase(this._repository);

  Future<List<PoiEntity>> call({required LatLng center, required double radiusMeters}) =>
      _repository.getPoisInRadius(center, radiusMeters);
}

/// Get POIs By Category Use Case
class GetPoisByCategoryUseCase {
  final MapRepository _repository;

  GetPoisByCategoryUseCase(this._repository);

  Future<List<PoiEntity>> call(PoiCategory category) => _repository.getPoisByCategory(category);
}

/// Search POIs Use Case
class SearchPoisUseCase {
  final MapRepository _repository;

  SearchPoisUseCase(this._repository);

  Future<List<PoiEntity>> call(String query) => _repository.searchPois(query);
}
