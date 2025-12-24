import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

/// Use case for fetching current user data
///
/// This use case encapsulates the business logic for retrieving
/// the current user's profile and wallet information.
///
/// **Single Responsibility:** Only fetches user data
/// **Reusability:** Can be used across different presentation layers
///
/// **Usage Example:**
/// ```dart
/// final useCase = GetCurrentUserUseCase(repository);
/// final user = await useCase();
/// 
/// print('User: ${user.fullName}');
/// print('Total Balance: ${user.totalBalance}');
/// ```
class GetCurrentUserUseCase {
  final UserRepository repository;

  GetCurrentUserUseCase(this.repository);

  /// Executes the use case
  ///
  /// Returns [UserEntity] with complete profile and wallets
  /// Throws [Exception] on errors
  Future<UserEntity> call() async {
    return await repository.getCurrentUser();
  }
}
