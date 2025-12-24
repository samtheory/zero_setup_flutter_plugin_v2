import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../domain/entities/wallet_entity.dart';
import 'user_notifier.dart';
import 'user_providers.dart';

/// AsyncNotifier for wallet management
class WalletNotifier extends AsyncNotifier<WalletEntity> {
  final int walletId;

  WalletNotifier(this.walletId);

  @override
  Future<WalletEntity> build() async {
    final userAsync = ref.read(userNotifierProvider);
    return userAsync.when(
      data: (user) {
        final wallet = user.findWallet(walletId);
        if (wallet == null) {
          throw Exception('Wallet not found');
        }
        return wallet;
      },
      loading: () => throw Exception('User data is loading'),
      error: (error, stack) => throw error,
    );
  }

  /// Adds income to the wallet
  Future<void> addIncome({required double amount, String? description}) async {
    await _updateBalance(amount: amount, isIncome: true, description: description);
  }

  /// Adds expense to the wallet (deducts from balance)
  Future<void> addExpense({required double amount, String? description}) async {
    await _updateBalance(amount: amount, isIncome: false, description: description);
  }

  /// Internal method to update wallet balance
  Future<void> _updateBalance({required double amount, required bool isIncome, String? description}) async {
    state = const AsyncValue.loading();

    try {
      final useCase = ref.read(updateWalletBalanceUseCaseProvider);
      final currentWallet = state.maybeWhen(
        data: (wallet) => wallet,
        orElse: () => null,
      );
      final updatedWallet = await useCase(
        walletId: walletId,
        amount: amount,
        isIncome: isIncome,
        description: description,
        currentWallet: currentWallet,
      );

      state = AsyncValue.data(updatedWallet);
      ref.read(userNotifierProvider.notifier).updateWalletInList(walletId, updatedWallet.balance);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }
}

/// Provider for WalletNotifier (Family)
///
/// **Usage:**
/// ```dart
/// // Watch wallet state
/// final walletAsync = ref.watch(walletNotifierProvider(101));
///
/// // Perform operations
/// await ref.read(walletNotifierProvider(101).notifier).addIncome(
///   amount: 50000,
///   description: 'Salary',
/// );
/// ```
final walletNotifierProvider =
    AsyncNotifierProvider.family<WalletNotifier, WalletEntity, int>(
  (walletId) => WalletNotifier(walletId),
);
