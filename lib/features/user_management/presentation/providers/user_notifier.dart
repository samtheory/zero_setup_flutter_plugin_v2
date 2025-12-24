import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/get_current_user_usecase.dart';
import '../../domain/usecases/update_user_usecase.dart';
import 'user_providers.dart';

/// AsyncNotifier for managing user state
///
/// This notifier handles user data fetching, updating, and state management.
/// It provides a clean interface for the UI to interact with user data.
///
/// **Features:**
/// - Automatic loading state management
/// - Error handling
/// - State updates on user profile changes
/// - Refresh capability
///
/// **Usage Example:**
/// ```dart
/// // In your widget
/// final userState = ref.watch(userNotifierProvider);
///
/// userState.when(
///   data: (user) => Text(user.fullName),
///   loading: () => CircularProgressIndicator(),
///   error: (error, stack) => Text('Error: $error'),
/// );
///
/// // Update user
/// await ref.read(userNotifierProvider.notifier).updateUserProfile(
///   name: 'New Name',
/// );
///
/// // Refresh
/// await ref.read(userNotifierProvider.notifier).refresh();
/// ```
class UserNotifier extends AsyncNotifier<UserEntity> {
  late GetCurrentUserUseCase _getCurrentUserUseCase;
  late UpdateUserUseCase _updateUserUseCase;

  @override
  Future<UserEntity> build() async {
    // Initialize use cases
    _getCurrentUserUseCase = ref.watch(getCurrentUserUseCaseProvider);
    _updateUserUseCase = ref.watch(updateUserUseCaseProvider);

    // Load initial user data
    return await _loadUser();
  }

  /// Loads user data from the API
  Future<UserEntity> _loadUser() async {
    try {
      return await _getCurrentUserUseCase();
    } catch (e) {
      throw Exception('Failed to load user: $e');
    }
  }

  /// Updates user profile information
  ///
  /// All parameters are optional - only provided fields will be updated
  /// Updates the state on success
  ///
  /// **Usage:**
  /// ```dart
  /// await notifier.updateUserProfile(
  ///   name: 'John',
  ///   email: 'john@example.com',
  /// );
  /// ```
  Future<void> updateUserProfile({
    String? name,
    String? lastName,
    String? nationalCode,
    String? mobile,
    String? email,
  }) async {
    // Set loading state
    state = const AsyncValue.loading();

    try {
      // Call use case
      final updatedUser = await _updateUserUseCase(
        name: name,
        lastName: lastName,
        nationalCode: nationalCode,
        mobile: mobile,
        email: email,
      );

      // Update state with new user data
      state = AsyncValue.data(updatedUser);
    } catch (e, stackTrace) {
      // Set error state
      state = AsyncValue.error(e, stackTrace);
      rethrow; // Allow UI to handle error
    }
  }

  /// Refreshes user data from the server
  ///
  /// **Usage:**
  /// ```dart
  /// await notifier.refresh();
  /// ```
  Future<void> refresh() async {
    state = const AsyncValue.loading();

    try {
      final user = await _loadUser();
      state = AsyncValue.data(user);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  /// Updates a specific wallet in the user's wallet list
  ///
  /// This is called by WalletNotifier to keep user state in sync
  /// when wallet balances change
  void updateWalletInList(int walletId, double newBalance) {
    state.whenData((user) {
      final updatedWallets = user.wallets.map((wallet) {
        if (wallet.id == walletId) {
          return wallet.copyWith(balance: newBalance);
        }
        return wallet;
      }).toList();

      final updatedUser = user.copyWith(wallets: updatedWallets);
      state = AsyncValue.data(updatedUser);
    });
  }
}

/// Provider for UserNotifier
///
/// This is the main provider to use in your widgets
///
/// **Usage:**
/// ```dart
/// // Watch user state
/// final userAsync = ref.watch(userNotifierProvider);
///
/// // Access notifier methods
/// ref.read(userNotifierProvider.notifier).updateUserProfile(...);
/// ```
final userNotifierProvider = AsyncNotifierProvider<UserNotifier, UserEntity>(() => UserNotifier());
