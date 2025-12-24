import '../entities/wallet_entity.dart';
import '../repositories/user_repository.dart';

/// Use case for updating wallet balance (income/expense)
///
/// This use case encapsulates the business logic for adding
/// income to or deducting expenses from a wallet.
///
/// **Business Rules:**
/// - Validates transaction amount
/// - Checks transaction limits
/// - Ensures sufficient balance for expenses
///
/// **Usage Example:**
/// ```dart
/// final useCase = UpdateWalletBalanceUseCase(repository);
/// 
/// // Add income
/// final updatedWallet = await useCase(
///   walletId: 101,
///   amount: 50000,
///   isIncome: true,
///   description: 'Salary',
/// );
/// 
/// // Add expense
/// final wallet = await useCase(
///   walletId: 101,
///   amount: 10000,
///   isIncome: false,
///   description: 'Purchase',
/// );
/// ```
class UpdateWalletBalanceUseCase {
  final UserRepository repository;

  UpdateWalletBalanceUseCase(this.repository);

  /// Executes the use case to update wallet balance
  ///
  /// [walletId] - ID of the wallet to update
  /// [amount] - Transaction amount (must be positive)
  /// [isIncome] - true for income, false for expense
  /// [description] - Optional transaction description
  /// [currentWallet] - Optional current wallet state for validation
  ///
  /// Returns updated [WalletEntity]
  /// Throws [Exception] on validation or business rule violations
  Future<WalletEntity> call({
    required int walletId,
    required double amount,
    required bool isIncome,
    String? description,
    WalletEntity? currentWallet,
  }) async {
    // Validate amount
    if (amount <= 0) {
      throw Exception('Amount must be greater than zero');
    }

    // If current wallet state is provided, perform business validations
    if (currentWallet != null) {
      _validateWalletState(currentWallet, amount, isIncome);
    }

    // Determine transaction type
    final transactionType = isIncome ? 'income' : 'expense';

    // Execute repository call
    return await repository.updateWalletBalance(
      walletId: walletId,
      amount: amount,
      transactionType: transactionType,
      description: description,
    );
  }

  /// Validates wallet state before transaction
  void _validateWalletState(
    WalletEntity wallet,
    double amount,
    bool isIncome,
  ) {
    // Check if wallet is suspended
    if (wallet.suspended) {
      throw Exception('Cannot perform transaction: Wallet is suspended');
    }

    // Check transaction limit
    if (amount > wallet.transactionLimit) {
      throw Exception(
        'Amount exceeds transaction limit of ${wallet.transactionLimit}',
      );
    }

    // For expenses, check if sufficient balance
    if (!isIncome && amount > wallet.balance) {
      throw Exception(
        'Insufficient balance. Available: ${wallet.balance}',
      );
    }
  }
}
