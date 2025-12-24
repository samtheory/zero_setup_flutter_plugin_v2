import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/wallet_entity.dart';

part 'wallet_model.freezed.dart';
part 'wallet_model.g.dart';

/// Data Transfer Object (DTO) for Wallet
///
/// This model handles JSON serialization/deserialization for wallet data
/// from API responses. It can be converted to/from domain entities.
///
/// **Usage Example:**
/// ```dart
/// // From JSON
/// final walletModel = WalletModel.fromJson(jsonData);
///
/// // Convert to domain entity
/// final walletEntity = walletModel.toEntity();
///
/// // From domain entity
/// final model = WalletModel.fromEntity(walletEntity);
///
/// // To JSON
/// final json = model.toJson();
/// ```
@Freezed()
abstract class WalletModel with _$WalletModel {
  const WalletModel._();

  const factory WalletModel({
    required int id,
    required int companyId,
    required int employeeId,
    required double balance,
    required String title,
    required double transactionLimit,
    required double feePercentForNormal,
    required double feePercentForFast,
    required bool suspended,
  }) = _WalletModel;

  /// Creates a WalletModel from JSON data
  ///
  /// Handles the conversion from API response format to model
  factory WalletModel.fromJson(Map<String, dynamic> json) => _$WalletModelFromJson(json);

  /// Converts this model to a domain entity
  ///
  /// This is the bridge between data layer and domain layer
  WalletEntity toEntity() {
    return WalletEntity(
      id: id,
      companyId: companyId,
      employeeId: employeeId,
      balance: balance,
      title: title,
      transactionLimit: transactionLimit,
      feePercentForNormal: feePercentForNormal,
      feePercentForFast: feePercentForFast,
      suspended: suspended,
    );
  }

  /// Creates a WalletModel from a domain entity
  ///
  /// Useful when you need to send entity data to the API
  factory WalletModel.fromEntity(WalletEntity entity) {
    return WalletModel(
      id: entity.id,
      companyId: entity.companyId,
      employeeId: entity.employeeId,
      balance: entity.balance,
      title: entity.title,
      transactionLimit: entity.transactionLimit,
      feePercentForNormal: entity.feePercentForNormal,
      feePercentForFast: entity.feePercentForFast,
      suspended: entity.suspended,
    );
  }
}
