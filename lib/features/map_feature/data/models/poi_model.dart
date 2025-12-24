import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/poi_entity.dart';

part 'poi_model.freezed.dart';
part 'poi_model.g.dart';

/// POI Data Transfer Object
///
/// Handles JSON serialization for POI data from APIs.
@Freezed()
abstract class PoiModel with _$PoiModel {
  const PoiModel._();

  const factory PoiModel({
    required String id,
    required String name,
    String? description,
    required double latitude,
    required double longitude,
    @Default('general') String category,
    String? imageUrl,
    Map<String, dynamic>? metadata,
  }) = _PoiModel;

  factory PoiModel.fromJson(Map<String, dynamic> json) => _$PoiModelFromJson(json);

  /// Convert to domain entity
  PoiEntity toEntity() => PoiEntity(
        id: id,
        name: name,
        description: description,
        latitude: latitude,
        longitude: longitude,
        category: _parseCategory(category),
        imageUrl: imageUrl,
        metadata: metadata,
      );

  /// Create from domain entity
  factory PoiModel.fromEntity(PoiEntity entity) => PoiModel(
        id: entity.id,
        name: entity.name,
        description: entity.description,
        latitude: entity.latitude,
        longitude: entity.longitude,
        category: entity.category.name,
        imageUrl: entity.imageUrl,
        metadata: entity.metadata,
      );

  static PoiCategory _parseCategory(String category) {
    return PoiCategory.values.firstWhere(
      (e) => e.name == category,
      orElse: () => PoiCategory.general,
    );
  }
}
