// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  lastName: json['lastName'] as String,
  nationalCode: json['nationalCode'] as String,
  mobile: json['mobile'] as String,
  email: json['email'] as String,
  status: json['status'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  wallets: (json['wallets'] as List<dynamic>)
      .map((e) => WalletModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$UserModelToJson(_UserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'lastName': instance.lastName,
      'nationalCode': instance.nationalCode,
      'mobile': instance.mobile,
      'email': instance.email,
      'status': instance.status,
      'createdAt': instance.createdAt.toIso8601String(),
      'wallets': instance.wallets,
    };

_UpdateUserDto _$UpdateUserDtoFromJson(Map<String, dynamic> json) =>
    _UpdateUserDto(
      name: json['name'] as String?,
      lastName: json['lastName'] as String?,
      nationalCode: json['nationalCode'] as String?,
      mobile: json['mobile'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$UpdateUserDtoToJson(_UpdateUserDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'lastName': instance.lastName,
      'nationalCode': instance.nationalCode,
      'mobile': instance.mobile,
      'email': instance.email,
    };

_WalletBalanceUpdateDto _$WalletBalanceUpdateDtoFromJson(
  Map<String, dynamic> json,
) => _WalletBalanceUpdateDto(
  amount: (json['amount'] as num).toDouble(),
  type: $enumDecode(_$TransactionTypeEnumMap, json['type']),
  description: json['description'] as String?,
);

Map<String, dynamic> _$WalletBalanceUpdateDtoToJson(
  _WalletBalanceUpdateDto instance,
) => <String, dynamic>{
  'amount': instance.amount,
  'type': _$TransactionTypeEnumMap[instance.type]!,
  'description': instance.description,
};

const _$TransactionTypeEnumMap = {
  TransactionType.income: 'income',
  TransactionType.expense: 'expense',
};
