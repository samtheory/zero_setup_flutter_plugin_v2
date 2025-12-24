// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WalletModel _$WalletModelFromJson(Map<String, dynamic> json) => _WalletModel(
  id: (json['id'] as num).toInt(),
  companyId: (json['companyId'] as num).toInt(),
  employeeId: (json['employeeId'] as num).toInt(),
  balance: (json['balance'] as num).toDouble(),
  title: json['title'] as String,
  transactionLimit: (json['transactionLimit'] as num).toDouble(),
  feePercentForNormal: (json['feePercentForNormal'] as num).toDouble(),
  feePercentForFast: (json['feePercentForFast'] as num).toDouble(),
  suspended: json['suspended'] as bool,
);

Map<String, dynamic> _$WalletModelToJson(_WalletModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'companyId': instance.companyId,
      'employeeId': instance.employeeId,
      'balance': instance.balance,
      'title': instance.title,
      'transactionLimit': instance.transactionLimit,
      'feePercentForNormal': instance.feePercentForNormal,
      'feePercentForFast': instance.feePercentForFast,
      'suspended': instance.suspended,
    };
