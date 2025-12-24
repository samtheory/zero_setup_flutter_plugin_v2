import '../entities/user_entity.dart';
import '../entities/wallet_entity.dart';

/// Repository interface for user management operations
///
/// This interface defines the contract for user data operations.
/// It follows the Repository pattern and Dependency Inversion principle,
/// allowing the domain layer to be independent of data sources.
///
/// **Implementation Note:**
/// Concrete implementations should be created in the data layer.
///
/// **Usage Example:**
/// ```dart
/// class MyService {
///   final UserRepository repository;
///   
///   MyService(this.repository);
///   
///   Future<UserEntity> loadUser() async {
///     final result = await repository.getCurrentUser();
///     return result.fold(
///       (failure) => throw Exception(failure.message),
///       (user) => user,
///     );
///   }
/// }
/// ```
abstract class UserRepository {
  /// Fetches the current user's data from the API
  ///
  /// Returns [UserEntity] with complete profile and wallet information
  /// Throws [Exception] on network or parsing errors
  Future<UserEntity> getCurrentUser();

  /// Updates the current user's profile information
  ///
  /// [updates] - Map of field names to new values (e.g., {'name': 'NewName'})
  /// Returns updated [UserEntity]
  /// Throws [Exception] on validation or network errors
  Future<UserEntity> updateUser(Map<String, dynamic> updates);

  /// Updates a specific wallet's balance
  ///
  /// [walletId] - The ID of the wallet to update
  /// [amount] - The amount to add (positive) or subtract (negative)
  /// [transactionType] - Either 'income' or 'expense'
  /// [description] - Optional description of the transaction
  ///
  /// Returns updated [WalletEntity]
  /// Throws [Exception] if wallet not found or insufficient balance
  Future<WalletEntity> updateWalletBalance({
    required int walletId,
    required double amount,
    required String transactionType,
    String? description,
  });

  /// Refreshes user data from the server
  ///
  /// Similar to [getCurrentUser] but may bypass cache
  Future<UserEntity> refreshUser();
}
