// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WalletModel {

 int get id; int get companyId; int get employeeId; double get balance; String get title; double get transactionLimit; double get feePercentForNormal; double get feePercentForFast; bool get suspended;
/// Create a copy of WalletModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WalletModelCopyWith<WalletModel> get copyWith => _$WalletModelCopyWithImpl<WalletModel>(this as WalletModel, _$identity);

  /// Serializes this WalletModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WalletModel&&(identical(other.id, id) || other.id == id)&&(identical(other.companyId, companyId) || other.companyId == companyId)&&(identical(other.employeeId, employeeId) || other.employeeId == employeeId)&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.title, title) || other.title == title)&&(identical(other.transactionLimit, transactionLimit) || other.transactionLimit == transactionLimit)&&(identical(other.feePercentForNormal, feePercentForNormal) || other.feePercentForNormal == feePercentForNormal)&&(identical(other.feePercentForFast, feePercentForFast) || other.feePercentForFast == feePercentForFast)&&(identical(other.suspended, suspended) || other.suspended == suspended));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,companyId,employeeId,balance,title,transactionLimit,feePercentForNormal,feePercentForFast,suspended);

@override
String toString() {
  return 'WalletModel(id: $id, companyId: $companyId, employeeId: $employeeId, balance: $balance, title: $title, transactionLimit: $transactionLimit, feePercentForNormal: $feePercentForNormal, feePercentForFast: $feePercentForFast, suspended: $suspended)';
}


}

/// @nodoc
abstract mixin class $WalletModelCopyWith<$Res>  {
  factory $WalletModelCopyWith(WalletModel value, $Res Function(WalletModel) _then) = _$WalletModelCopyWithImpl;
@useResult
$Res call({
 int id, int companyId, int employeeId, double balance, String title, double transactionLimit, double feePercentForNormal, double feePercentForFast, bool suspended
});




}
/// @nodoc
class _$WalletModelCopyWithImpl<$Res>
    implements $WalletModelCopyWith<$Res> {
  _$WalletModelCopyWithImpl(this._self, this._then);

  final WalletModel _self;
  final $Res Function(WalletModel) _then;

/// Create a copy of WalletModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? companyId = null,Object? employeeId = null,Object? balance = null,Object? title = null,Object? transactionLimit = null,Object? feePercentForNormal = null,Object? feePercentForFast = null,Object? suspended = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,companyId: null == companyId ? _self.companyId : companyId // ignore: cast_nullable_to_non_nullable
as int,employeeId: null == employeeId ? _self.employeeId : employeeId // ignore: cast_nullable_to_non_nullable
as int,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as double,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,transactionLimit: null == transactionLimit ? _self.transactionLimit : transactionLimit // ignore: cast_nullable_to_non_nullable
as double,feePercentForNormal: null == feePercentForNormal ? _self.feePercentForNormal : feePercentForNormal // ignore: cast_nullable_to_non_nullable
as double,feePercentForFast: null == feePercentForFast ? _self.feePercentForFast : feePercentForFast // ignore: cast_nullable_to_non_nullable
as double,suspended: null == suspended ? _self.suspended : suspended // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [WalletModel].
extension WalletModelPatterns on WalletModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WalletModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WalletModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WalletModel value)  $default,){
final _that = this;
switch (_that) {
case _WalletModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WalletModel value)?  $default,){
final _that = this;
switch (_that) {
case _WalletModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int companyId,  int employeeId,  double balance,  String title,  double transactionLimit,  double feePercentForNormal,  double feePercentForFast,  bool suspended)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WalletModel() when $default != null:
return $default(_that.id,_that.companyId,_that.employeeId,_that.balance,_that.title,_that.transactionLimit,_that.feePercentForNormal,_that.feePercentForFast,_that.suspended);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int companyId,  int employeeId,  double balance,  String title,  double transactionLimit,  double feePercentForNormal,  double feePercentForFast,  bool suspended)  $default,) {final _that = this;
switch (_that) {
case _WalletModel():
return $default(_that.id,_that.companyId,_that.employeeId,_that.balance,_that.title,_that.transactionLimit,_that.feePercentForNormal,_that.feePercentForFast,_that.suspended);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int companyId,  int employeeId,  double balance,  String title,  double transactionLimit,  double feePercentForNormal,  double feePercentForFast,  bool suspended)?  $default,) {final _that = this;
switch (_that) {
case _WalletModel() when $default != null:
return $default(_that.id,_that.companyId,_that.employeeId,_that.balance,_that.title,_that.transactionLimit,_that.feePercentForNormal,_that.feePercentForFast,_that.suspended);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WalletModel extends WalletModel {
  const _WalletModel({required this.id, required this.companyId, required this.employeeId, required this.balance, required this.title, required this.transactionLimit, required this.feePercentForNormal, required this.feePercentForFast, required this.suspended}): super._();
  factory _WalletModel.fromJson(Map<String, dynamic> json) => _$WalletModelFromJson(json);

@override final  int id;
@override final  int companyId;
@override final  int employeeId;
@override final  double balance;
@override final  String title;
@override final  double transactionLimit;
@override final  double feePercentForNormal;
@override final  double feePercentForFast;
@override final  bool suspended;

/// Create a copy of WalletModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WalletModelCopyWith<_WalletModel> get copyWith => __$WalletModelCopyWithImpl<_WalletModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WalletModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WalletModel&&(identical(other.id, id) || other.id == id)&&(identical(other.companyId, companyId) || other.companyId == companyId)&&(identical(other.employeeId, employeeId) || other.employeeId == employeeId)&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.title, title) || other.title == title)&&(identical(other.transactionLimit, transactionLimit) || other.transactionLimit == transactionLimit)&&(identical(other.feePercentForNormal, feePercentForNormal) || other.feePercentForNormal == feePercentForNormal)&&(identical(other.feePercentForFast, feePercentForFast) || other.feePercentForFast == feePercentForFast)&&(identical(other.suspended, suspended) || other.suspended == suspended));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,companyId,employeeId,balance,title,transactionLimit,feePercentForNormal,feePercentForFast,suspended);

@override
String toString() {
  return 'WalletModel(id: $id, companyId: $companyId, employeeId: $employeeId, balance: $balance, title: $title, transactionLimit: $transactionLimit, feePercentForNormal: $feePercentForNormal, feePercentForFast: $feePercentForFast, suspended: $suspended)';
}


}

/// @nodoc
abstract mixin class _$WalletModelCopyWith<$Res> implements $WalletModelCopyWith<$Res> {
  factory _$WalletModelCopyWith(_WalletModel value, $Res Function(_WalletModel) _then) = __$WalletModelCopyWithImpl;
@override @useResult
$Res call({
 int id, int companyId, int employeeId, double balance, String title, double transactionLimit, double feePercentForNormal, double feePercentForFast, bool suspended
});




}
/// @nodoc
class __$WalletModelCopyWithImpl<$Res>
    implements _$WalletModelCopyWith<$Res> {
  __$WalletModelCopyWithImpl(this._self, this._then);

  final _WalletModel _self;
  final $Res Function(_WalletModel) _then;

/// Create a copy of WalletModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? companyId = null,Object? employeeId = null,Object? balance = null,Object? title = null,Object? transactionLimit = null,Object? feePercentForNormal = null,Object? feePercentForFast = null,Object? suspended = null,}) {
  return _then(_WalletModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,companyId: null == companyId ? _self.companyId : companyId // ignore: cast_nullable_to_non_nullable
as int,employeeId: null == employeeId ? _self.employeeId : employeeId // ignore: cast_nullable_to_non_nullable
as int,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as double,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,transactionLimit: null == transactionLimit ? _self.transactionLimit : transactionLimit // ignore: cast_nullable_to_non_nullable
as double,feePercentForNormal: null == feePercentForNormal ? _self.feePercentForNormal : feePercentForNormal // ignore: cast_nullable_to_non_nullable
as double,feePercentForFast: null == feePercentForFast ? _self.feePercentForFast : feePercentForFast // ignore: cast_nullable_to_non_nullable
as double,suspended: null == suspended ? _self.suspended : suspended // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
