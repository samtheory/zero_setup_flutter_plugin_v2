// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poi_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PoiModel _$PoiModelFromJson(Map<String, dynamic> json) => _PoiModel(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  category: json['category'] as String? ?? 'general',
  imageUrl: json['imageUrl'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$PoiModelToJson(_PoiModel instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'category': instance.category,
  'imageUrl': instance.imageUrl,
  'metadata': instance.metadata,
};
