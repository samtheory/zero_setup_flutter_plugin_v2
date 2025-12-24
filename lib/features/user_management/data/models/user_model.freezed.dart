// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserModel {

 int get id; String get name; String get lastName; String get nationalCode; String get mobile; String get email; String get status; DateTime get createdAt; List<WalletModel> get wallets;
/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserModelCopyWith<UserModel> get copyWith => _$UserModelCopyWithImpl<UserModel>(this as UserModel, _$identity);

  /// Serializes this UserModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.nationalCode, nationalCode) || other.nationalCode == nationalCode)&&(identical(other.mobile, mobile) || other.mobile == mobile)&&(identical(other.email, email) || other.email == email)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.wallets, wallets));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,lastName,nationalCode,mobile,email,status,createdAt,const DeepCollectionEquality().hash(wallets));

@override
String toString() {
  return 'UserModel(id: $id, name: $name, lastName: $lastName, nationalCode: $nationalCode, mobile: $mobile, email: $email, status: $status, createdAt: $createdAt, wallets: $wallets)';
}


}

/// @nodoc
abstract mixin class $UserModelCopyWith<$Res>  {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) _then) = _$UserModelCopyWithImpl;
@useResult
$Res call({
 int id, String name, String lastName, String nationalCode, String mobile, String email, String status, DateTime createdAt, List<WalletModel> wallets
});




}
/// @nodoc
class _$UserModelCopyWithImpl<$Res>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._self, this._then);

  final UserModel _self;
  final $Res Function(UserModel) _then;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? lastName = null,Object? nationalCode = null,Object? mobile = null,Object? email = null,Object? status = null,Object? createdAt = null,Object? wallets = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,nationalCode: null == nationalCode ? _self.nationalCode : nationalCode // ignore: cast_nullable_to_non_nullable
as String,mobile: null == mobile ? _self.mobile : mobile // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,wallets: null == wallets ? _self.wallets : wallets // ignore: cast_nullable_to_non_nullable
as List<WalletModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [UserModel].
extension UserModelPatterns on UserModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserModel value)  $default,){
final _that = this;
switch (_that) {
case _UserModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String lastName,  String nationalCode,  String mobile,  String email,  String status,  DateTime createdAt,  List<WalletModel> wallets)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserModel() when $default != null:
return $default(_that.id,_that.name,_that.lastName,_that.nationalCode,_that.mobile,_that.email,_that.status,_that.createdAt,_that.wallets);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String lastName,  String nationalCode,  String mobile,  String email,  String status,  DateTime createdAt,  List<WalletModel> wallets)  $default,) {final _that = this;
switch (_that) {
case _UserModel():
return $default(_that.id,_that.name,_that.lastName,_that.nationalCode,_that.mobile,_that.email,_that.status,_that.createdAt,_that.wallets);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String lastName,  String nationalCode,  String mobile,  String email,  String status,  DateTime createdAt,  List<WalletModel> wallets)?  $default,) {final _that = this;
switch (_that) {
case _UserModel() when $default != null:
return $default(_that.id,_that.name,_that.lastName,_that.nationalCode,_that.mobile,_that.email,_that.status,_that.createdAt,_that.wallets);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserModel extends UserModel {
  const _UserModel({required this.id, required this.name, required this.lastName, required this.nationalCode, required this.mobile, required this.email, required this.status, required this.createdAt, required final  List<WalletModel> wallets}): _wallets = wallets,super._();
  factory _UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

@override final  int id;
@override final  String name;
@override final  String lastName;
@override final  String nationalCode;
@override final  String mobile;
@override final  String email;
@override final  String status;
@override final  DateTime createdAt;
 final  List<WalletModel> _wallets;
@override List<WalletModel> get wallets {
  if (_wallets is EqualUnmodifiableListView) return _wallets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_wallets);
}


/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserModelCopyWith<_UserModel> get copyWith => __$UserModelCopyWithImpl<_UserModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.nationalCode, nationalCode) || other.nationalCode == nationalCode)&&(identical(other.mobile, mobile) || other.mobile == mobile)&&(identical(other.email, email) || other.email == email)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other._wallets, _wallets));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,lastName,nationalCode,mobile,email,status,createdAt,const DeepCollectionEquality().hash(_wallets));

@override
String toString() {
  return 'UserModel(id: $id, name: $name, lastName: $lastName, nationalCode: $nationalCode, mobile: $mobile, email: $email, status: $status, createdAt: $createdAt, wallets: $wallets)';
}


}

/// @nodoc
abstract mixin class _$UserModelCopyWith<$Res> implements $UserModelCopyWith<$Res> {
  factory _$UserModelCopyWith(_UserModel value, $Res Function(_UserModel) _then) = __$UserModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String lastName, String nationalCode, String mobile, String email, String status, DateTime createdAt, List<WalletModel> wallets
});




}
/// @nodoc
class __$UserModelCopyWithImpl<$Res>
    implements _$UserModelCopyWith<$Res> {
  __$UserModelCopyWithImpl(this._self, this._then);

  final _UserModel _self;
  final $Res Function(_UserModel) _then;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? lastName = null,Object? nationalCode = null,Object? mobile = null,Object? email = null,Object? status = null,Object? createdAt = null,Object? wallets = null,}) {
  return _then(_UserModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,nationalCode: null == nationalCode ? _self.nationalCode : nationalCode // ignore: cast_nullable_to_non_nullable
as String,mobile: null == mobile ? _self.mobile : mobile // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,wallets: null == wallets ? _self._wallets : wallets // ignore: cast_nullable_to_non_nullable
as List<WalletModel>,
  ));
}


}


/// @nodoc
mixin _$UpdateUserDto {

 String? get name; String? get lastName; String? get nationalCode; String? get mobile; String? get email;
/// Create a copy of UpdateUserDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateUserDtoCopyWith<UpdateUserDto> get copyWith => _$UpdateUserDtoCopyWithImpl<UpdateUserDto>(this as UpdateUserDto, _$identity);

  /// Serializes this UpdateUserDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateUserDto&&(identical(other.name, name) || other.name == name)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.nationalCode, nationalCode) || other.nationalCode == nationalCode)&&(identical(other.mobile, mobile) || other.mobile == mobile)&&(identical(other.email, email) || other.email == email));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,lastName,nationalCode,mobile,email);

@override
String toString() {
  return 'UpdateUserDto(name: $name, lastName: $lastName, nationalCode: $nationalCode, mobile: $mobile, email: $email)';
}


}

/// @nodoc
abstract mixin class $UpdateUserDtoCopyWith<$Res>  {
  factory $UpdateUserDtoCopyWith(UpdateUserDto value, $Res Function(UpdateUserDto) _then) = _$UpdateUserDtoCopyWithImpl;
@useResult
$Res call({
 String? name, String? lastName, String? nationalCode, String? mobile, String? email
});




}
/// @nodoc
class _$UpdateUserDtoCopyWithImpl<$Res>
    implements $UpdateUserDtoCopyWith<$Res> {
  _$UpdateUserDtoCopyWithImpl(this._self, this._then);

  final UpdateUserDto _self;
  final $Res Function(UpdateUserDto) _then;

/// Create a copy of UpdateUserDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = freezed,Object? lastName = freezed,Object? nationalCode = freezed,Object? mobile = freezed,Object? email = freezed,}) {
  return _then(_self.copyWith(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,nationalCode: freezed == nationalCode ? _self.nationalCode : nationalCode // ignore: cast_nullable_to_non_nullable
as String?,mobile: freezed == mobile ? _self.mobile : mobile // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UpdateUserDto].
extension UpdateUserDtoPatterns on UpdateUserDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpdateUserDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpdateUserDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpdateUserDto value)  $default,){
final _that = this;
switch (_that) {
case _UpdateUserDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpdateUserDto value)?  $default,){
final _that = this;
switch (_that) {
case _UpdateUserDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? name,  String? lastName,  String? nationalCode,  String? mobile,  String? email)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpdateUserDto() when $default != null:
return $default(_that.name,_that.lastName,_that.nationalCode,_that.mobile,_that.email);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? name,  String? lastName,  String? nationalCode,  String? mobile,  String? email)  $default,) {final _that = this;
switch (_that) {
case _UpdateUserDto():
return $default(_that.name,_that.lastName,_that.nationalCode,_that.mobile,_that.email);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? name,  String? lastName,  String? nationalCode,  String? mobile,  String? email)?  $default,) {final _that = this;
switch (_that) {
case _UpdateUserDto() when $default != null:
return $default(_that.name,_that.lastName,_that.nationalCode,_that.mobile,_that.email);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UpdateUserDto implements UpdateUserDto {
  const _UpdateUserDto({this.name, this.lastName, this.nationalCode, this.mobile, this.email});
  factory _UpdateUserDto.fromJson(Map<String, dynamic> json) => _$UpdateUserDtoFromJson(json);

@override final  String? name;
@override final  String? lastName;
@override final  String? nationalCode;
@override final  String? mobile;
@override final  String? email;

/// Create a copy of UpdateUserDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateUserDtoCopyWith<_UpdateUserDto> get copyWith => __$UpdateUserDtoCopyWithImpl<_UpdateUserDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpdateUserDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateUserDto&&(identical(other.name, name) || other.name == name)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.nationalCode, nationalCode) || other.nationalCode == nationalCode)&&(identical(other.mobile, mobile) || other.mobile == mobile)&&(identical(other.email, email) || other.email == email));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,lastName,nationalCode,mobile,email);

@override
String toString() {
  return 'UpdateUserDto(name: $name, lastName: $lastName, nationalCode: $nationalCode, mobile: $mobile, email: $email)';
}


}

/// @nodoc
abstract mixin class _$UpdateUserDtoCopyWith<$Res> implements $UpdateUserDtoCopyWith<$Res> {
  factory _$UpdateUserDtoCopyWith(_UpdateUserDto value, $Res Function(_UpdateUserDto) _then) = __$UpdateUserDtoCopyWithImpl;
@override @useResult
$Res call({
 String? name, String? lastName, String? nationalCode, String? mobile, String? email
});




}
/// @nodoc
class __$UpdateUserDtoCopyWithImpl<$Res>
    implements _$UpdateUserDtoCopyWith<$Res> {
  __$UpdateUserDtoCopyWithImpl(this._self, this._then);

  final _UpdateUserDto _self;
  final $Res Function(_UpdateUserDto) _then;

/// Create a copy of UpdateUserDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = freezed,Object? lastName = freezed,Object? nationalCode = freezed,Object? mobile = freezed,Object? email = freezed,}) {
  return _then(_UpdateUserDto(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,nationalCode: freezed == nationalCode ? _self.nationalCode : nationalCode // ignore: cast_nullable_to_non_nullable
as String?,mobile: freezed == mobile ? _self.mobile : mobile // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$WalletBalanceUpdateDto {

 double get amount; TransactionType get type; String? get description;
/// Create a copy of WalletBalanceUpdateDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WalletBalanceUpdateDtoCopyWith<WalletBalanceUpdateDto> get copyWith => _$WalletBalanceUpdateDtoCopyWithImpl<WalletBalanceUpdateDto>(this as WalletBalanceUpdateDto, _$identity);

  /// Serializes this WalletBalanceUpdateDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WalletBalanceUpdateDto&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.type, type) || other.type == type)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,amount,type,description);

@override
String toString() {
  return 'WalletBalanceUpdateDto(amount: $amount, type: $type, description: $description)';
}


}

/// @nodoc
abstract mixin class $WalletBalanceUpdateDtoCopyWith<$Res>  {
  factory $WalletBalanceUpdateDtoCopyWith(WalletBalanceUpdateDto value, $Res Function(WalletBalanceUpdateDto) _then) = _$WalletBalanceUpdateDtoCopyWithImpl;
@useResult
$Res call({
 double amount, TransactionType type, String? description
});




}
/// @nodoc
class _$WalletBalanceUpdateDtoCopyWithImpl<$Res>
    implements $WalletBalanceUpdateDtoCopyWith<$Res> {
  _$WalletBalanceUpdateDtoCopyWithImpl(this._self, this._then);

  final WalletBalanceUpdateDto _self;
  final $Res Function(WalletBalanceUpdateDto) _then;

/// Create a copy of WalletBalanceUpdateDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? amount = null,Object? type = null,Object? description = freezed,}) {
  return _then(_self.copyWith(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TransactionType,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [WalletBalanceUpdateDto].
extension WalletBalanceUpdateDtoPatterns on WalletBalanceUpdateDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WalletBalanceUpdateDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WalletBalanceUpdateDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WalletBalanceUpdateDto value)  $default,){
final _that = this;
switch (_that) {
case _WalletBalanceUpdateDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WalletBalanceUpdateDto value)?  $default,){
final _that = this;
switch (_that) {
case _WalletBalanceUpdateDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double amount,  TransactionType type,  String? description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WalletBalanceUpdateDto() when $default != null:
return $default(_that.amount,_that.type,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double amount,  TransactionType type,  String? description)  $default,) {final _that = this;
switch (_that) {
case _WalletBalanceUpdateDto():
return $default(_that.amount,_that.type,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double amount,  TransactionType type,  String? description)?  $default,) {final _that = this;
switch (_that) {
case _WalletBalanceUpdateDto() when $default != null:
return $default(_that.amount,_that.type,_that.description);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WalletBalanceUpdateDto implements WalletBalanceUpdateDto {
  const _WalletBalanceUpdateDto({required this.amount, required this.type, this.description});
  factory _WalletBalanceUpdateDto.fromJson(Map<String, dynamic> json) => _$WalletBalanceUpdateDtoFromJson(json);

@override final  double amount;
@override final  TransactionType type;
@override final  String? description;

/// Create a copy of WalletBalanceUpdateDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WalletBalanceUpdateDtoCopyWith<_WalletBalanceUpdateDto> get copyWith => __$WalletBalanceUpdateDtoCopyWithImpl<_WalletBalanceUpdateDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WalletBalanceUpdateDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WalletBalanceUpdateDto&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.type, type) || other.type == type)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,amount,type,description);

@override
String toString() {
  return 'WalletBalanceUpdateDto(amount: $amount, type: $type, description: $description)';
}


}

/// @nodoc
abstract mixin class _$WalletBalanceUpdateDtoCopyWith<$Res> implements $WalletBalanceUpdateDtoCopyWith<$Res> {
  factory _$WalletBalanceUpdateDtoCopyWith(_WalletBalanceUpdateDto value, $Res Function(_WalletBalanceUpdateDto) _then) = __$WalletBalanceUpdateDtoCopyWithImpl;
@override @useResult
$Res call({
 double amount, TransactionType type, String? description
});




}
/// @nodoc
class __$WalletBalanceUpdateDtoCopyWithImpl<$Res>
    implements _$WalletBalanceUpdateDtoCopyWith<$Res> {
  __$WalletBalanceUpdateDtoCopyWithImpl(this._self, this._then);

  final _WalletBalanceUpdateDto _self;
  final $Res Function(_WalletBalanceUpdateDto) _then;

/// Create a copy of WalletBalanceUpdateDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? amount = null,Object? type = null,Object? description = freezed,}) {
  return _then(_WalletBalanceUpdateDto(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TransactionType,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
