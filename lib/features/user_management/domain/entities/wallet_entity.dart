/// Wallet entity representing an employee's wallet in the domain layer.
///
/// This entity encapsulates all wallet-related business logic and validation.
/// It's immutable and framework-independent, making it reusable across different
/// presentation and data layer implementations.
///
/// **Usage Example:**
/// ```dart
/// final wallet = WalletEntity(
///   id: 101,
///   companyId: 12,
///   employeeId: 445,
///   balance: 325000,
///   title: 'Main Wallet',
///   transactionLimit: 500000,
///   feePercentForNormal: 2,
///   feePercentForFast: 5,
///   suspended: false,
/// );
///
/// // Check if wallet can process a transaction
/// if (wallet.canProcessTransaction(100000)) {
///   // Process transaction
/// }
/// ```
class WalletEntity {
  /// Unique identifier for the wallet
  final int id;

  /// ID of the company this wallet belongs to
  final int companyId;

  /// ID of the employee who owns this wallet
  final int employeeId;

  /// Current balance in the wallet (in smallest currency unit, e.g., cents)
  final double balance;

  /// Display title/name for the wallet
  final String title;

  /// Maximum amount allowed per transaction
  final double transactionLimit;

  /// Fee percentage for normal transactions
  final double feePercentForNormal;

  /// Fee percentage for fast/expedited transactions
  final double feePercentForFast;

  /// Whether the wallet is currently suspended/blocked
  final bool suspended;

  const WalletEntity({
    required this.id,
    required this.companyId,
    required this.employeeId,
    required this.balance,
    required this.title,
    required this.transactionLimit,
    required this.feePercentForNormal,
    required this.feePercentForFast,
    required this.suspended,
  });

  /// Checks if the wallet can process a transaction of the given amount
  ///
  /// Returns `true` if:
  /// - Wallet is not suspended
  /// - Amount is within transaction limit
  /// - Wallet has sufficient balance
  bool canProcessTransaction(double amount) {
    return !suspended && 
           amount <= transactionLimit && 
           amount <= balance;
  }

  /// Checks if the wallet is active and usable
  bool get isActive => !suspended && balance >= 0;

  /// Calculates the fee for a normal transaction
  double calculateNormalFee(double amount) {
    return amount * (feePercentForNormal / 100);
  }

  /// Calculates the fee for a fast transaction
  double calculateFastFee(double amount) {
    return amount * (feePercentForFast / 100);
  }

  /// Creates a copy of this wallet with updated balance
  ///
  /// This is useful for updating wallet state after transactions
  WalletEntity copyWith({
    int? id,
    int? companyId,
    int? employeeId,
    double? balance,
    String? title,
    double? transactionLimit,
    double? feePercentForNormal,
    double? feePercentForFast,
    bool? suspended,
  }) {
    return WalletEntity(
      id: id ?? this.id,
      companyId: companyId ?? this.companyId,
      employeeId: employeeId ?? this.employeeId,
      balance: balance ?? this.balance,
      title: title ?? this.title,
      transactionLimit: transactionLimit ?? this.transactionLimit,
      feePercentForNormal: feePercentForNormal ?? this.feePercentForNormal,
      feePercentForFast: feePercentForFast ?? this.feePercentForFast,
      suspended: suspended ?? this.suspended,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WalletEntity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'WalletEntity(id: $id, title: $title, balance: $balance, suspended: $suspended)';
  }
}
