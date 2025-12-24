// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'poi_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PoiModel {

 String get id; String get name; String? get description; double get latitude; double get longitude; String get category; String? get imageUrl; Map<String, dynamic>? get metadata;
/// Create a copy of PoiModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PoiModelCopyWith<PoiModel> get copyWith => _$PoiModelCopyWithImpl<PoiModel>(this as PoiModel, _$identity);

  /// Serializes this PoiModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PoiModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.category, category) || other.category == category)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,latitude,longitude,category,imageUrl,const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'PoiModel(id: $id, name: $name, description: $description, latitude: $latitude, longitude: $longitude, category: $category, imageUrl: $imageUrl, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $PoiModelCopyWith<$Res>  {
  factory $PoiModelCopyWith(PoiModel value, $Res Function(PoiModel) _then) = _$PoiModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? description, double latitude, double longitude, String category, String? imageUrl, Map<String, dynamic>? metadata
});




}
/// @nodoc
class _$PoiModelCopyWithImpl<$Res>
    implements $PoiModelCopyWith<$Res> {
  _$PoiModelCopyWithImpl(this._self, this._then);

  final PoiModel _self;
  final $Res Function(PoiModel) _then;

/// Create a copy of PoiModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? latitude = null,Object? longitude = null,Object? category = null,Object? imageUrl = freezed,Object? metadata = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [PoiModel].
extension PoiModelPatterns on PoiModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PoiModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PoiModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PoiModel value)  $default,){
final _that = this;
switch (_that) {
case _PoiModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PoiModel value)?  $default,){
final _that = this;
switch (_that) {
case _PoiModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? description,  double latitude,  double longitude,  String category,  String? imageUrl,  Map<String, dynamic>? metadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PoiModel() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.latitude,_that.longitude,_that.category,_that.imageUrl,_that.metadata);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? description,  double latitude,  double longitude,  String category,  String? imageUrl,  Map<String, dynamic>? metadata)  $default,) {final _that = this;
switch (_that) {
case _PoiModel():
return $default(_that.id,_that.name,_that.description,_that.latitude,_that.longitude,_that.category,_that.imageUrl,_that.metadata);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? description,  double latitude,  double longitude,  String category,  String? imageUrl,  Map<String, dynamic>? metadata)?  $default,) {final _that = this;
switch (_that) {
case _PoiModel() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.latitude,_that.longitude,_that.category,_that.imageUrl,_that.metadata);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PoiModel extends PoiModel {
  const _PoiModel({required this.id, required this.name, this.description, required this.latitude, required this.longitude, this.category = 'general', this.imageUrl, final  Map<String, dynamic>? metadata}): _metadata = metadata,super._();
  factory _PoiModel.fromJson(Map<String, dynamic> json) => _$PoiModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? description;
@override final  double latitude;
@override final  double longitude;
@override@JsonKey() final  String category;
@override final  String? imageUrl;
 final  Map<String, dynamic>? _metadata;
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of PoiModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PoiModelCopyWith<_PoiModel> get copyWith => __$PoiModelCopyWithImpl<_PoiModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PoiModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PoiModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.category, category) || other.category == category)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,latitude,longitude,category,imageUrl,const DeepCollectionEquality().hash(_metadata));

@override
String toString() {
  return 'PoiModel(id: $id, name: $name, description: $description, latitude: $latitude, longitude: $longitude, category: $category, imageUrl: $imageUrl, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$PoiModelCopyWith<$Res> implements $PoiModelCopyWith<$Res> {
  factory _$PoiModelCopyWith(_PoiModel value, $Res Function(_PoiModel) _then) = __$PoiModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? description, double latitude, double longitude, String category, String? imageUrl, Map<String, dynamic>? metadata
});




}
/// @nodoc
class __$PoiModelCopyWithImpl<$Res>
    implements _$PoiModelCopyWith<$Res> {
  __$PoiModelCopyWithImpl(this._self, this._then);

  final _PoiModel _self;
  final $Res Function(_PoiModel) _then;

/// Create a copy of PoiModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? latitude = null,Object? longitude = null,Object? category = null,Object? imageUrl = freezed,Object? metadata = freezed,}) {
  return _then(_PoiModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

// dart format on
