
import '../../domain/entities/user_entity.dart';
import 'wallet_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

/// Data Transfer Object (DTO) for User/Employee
///
/// This model handles JSON serialization/deserialization for user data
/// from API responses. It can be converted to/from domain entities.
///
/// **Usage Example:**
/// ```dart
/// // From JSON API response
/// final userModel = UserModel.fromJson(jsonData);
///
/// // Convert to domain entity
/// final userEntity = userModel.toEntity();
///
/// // From domain entity (for API requests)
/// final model = UserModel.fromEntity(userEntity);
///
/// // To JSON (for API requests)
/// final json = model.toJson();
/// ```
@freezed
abstract class UserModel with _$UserModel {
  const UserModel._();

  const factory UserModel({
    required int id,
    required String name,
    required String lastName,
    required String nationalCode,
    required String mobile,
    required String email,
    required String status,
    required DateTime createdAt,
    required List<WalletModel> wallets,
  }) = _UserModel;

  /// Creates a UserModel from JSON data
  ///
  /// Automatically handles nested wallet data conversion
  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  /// Converts this model to a domain entity
  ///
  /// This is the bridge between data layer and domain layer.
  /// Converts status string to enum and wallet models to entities.
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      name: name,
      lastName: lastName,
      nationalCode: nationalCode,
      mobile: mobile,
      email: email,
      status: UserStatus.fromString(status),
      createdAt: createdAt,
      wallets: wallets.map((w) => w.toEntity()).toList(),
    );
  }

  /// Creates a UserModel from a domain entity
  ///
  /// Useful when you need to send entity data to the API
  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      name: entity.name,
      lastName: entity.lastName,
      nationalCode: entity.nationalCode,
      mobile: entity.mobile,
      email: entity.email,
      status: entity.status.value,
      createdAt: entity.createdAt,
      wallets: entity.wallets.map((w) => WalletModel.fromEntity(w)).toList(),
    );
  }
}

/// DTO for updating user data
///
/// Contains only the fields that can be updated via PATCH/PUT requests
///
/// **Usage Example:**
/// ```dart
/// final updateDto = UpdateUserDto(
///   name: 'NewName',
///   email: 'newemail@example.com',
/// );
///
/// final json = updateDto.toJson();
/// // Send to API: PATCH /me with json body
/// ```
@Freezed()
abstract class UpdateUserDto with _$UpdateUserDto {
  const factory UpdateUserDto({String? name, String? lastName, String? nationalCode, String? mobile, String? email}) =
      _UpdateUserDto;

  factory UpdateUserDto.fromJson(Map<String, dynamic> json) => _$UpdateUserDtoFromJson(json);
}

/// DTO for wallet balance update requests
///
/// Used when adding income or expense to a wallet
///
/// **Usage Example:**
/// ```dart
/// // Add income
/// final incomeDto = WalletBalanceUpdateDto(
///   amount: 50000,
///   type: TransactionType.income,
///   description: 'Salary deposit',
/// );
///
/// // Add expense
/// final expenseDto = WalletBalanceUpdateDto(
///   amount: 10000,
///   type: TransactionType.expense,
///   description: 'Purchase',
/// );
/// ```
@Freezed()
abstract class WalletBalanceUpdateDto with _$WalletBalanceUpdateDto {
  const factory WalletBalanceUpdateDto({required double amount, required TransactionType type, String? description}) =
      _WalletBalanceUpdateDto;

  factory WalletBalanceUpdateDto.fromJson(Map<String, dynamic> json) => _$WalletBalanceUpdateDtoFromJson(json);
}

/// Transaction type enum for wallet operations
enum TransactionType {
  @JsonValue('income')
  income,
  @JsonValue('expense')
  expense,
}
