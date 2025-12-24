import 'wallet_entity.dart';

/// User/Employee entity representing a user in the domain layer.
///
/// This entity encapsulates all user-related business logic and validation.
/// It's immutable and framework-independent, following clean architecture principles.
///
/// **Usage Example:**
/// ```dart
/// final user = UserEntity(
///   id: 445,
///   name: 'Ali',
///   lastName: 'Ahmadi',
///   nationalCode: '1234567890',
///   mobile: '+989121234567',
///   email: 'ali.ahmadi@example.com',
///   status: UserStatus.active,
///   createdAt: DateTime.parse('2024-01-15T10:45:32Z'),
///   wallets: [wallet1, wallet2],
/// );
///
/// // Check if user is active
/// if (user.isActive) {
///   // Allow operations
/// }
///
/// // Get total balance across all wallets
/// final totalBalance = user.totalBalance;
/// ```
class UserEntity {
  /// Unique identifier for the user
  final int id;

  /// User's first name
  final String name;

  /// User's last name
  final String lastName;

  /// National identification code
  final String nationalCode;

  /// Mobile phone number (international format recommended)
  final String mobile;

  /// Email address
  final String email;

  /// Current status of the user account
  final UserStatus status;

  /// Timestamp when the account was created
  final DateTime createdAt;

  /// List of wallets associated with this user
  final List<WalletEntity> wallets;

  const UserEntity({
    required this.id,
    required this.name,
    required this.lastName,
    required this.nationalCode,
    required this.mobile,
    required this.email,
    required this.status,
    required this.createdAt,
    required this.wallets,
  });

  /// Returns the user's full name
  String get fullName => '$name $lastName';

  /// Checks if the user account is active
  bool get isActive => status == UserStatus.active;

  /// Calculates total balance across all active wallets
  double get totalBalance {
    return wallets
        .where((wallet) => !wallet.suspended)
        .fold(0.0, (sum, wallet) => sum + wallet.balance);
  }

  /// Gets all active (non-suspended) wallets
  List<WalletEntity> get activeWallets {
    return wallets.where((wallet) => !wallet.suspended).toList();
  }

  /// Gets all suspended wallets
  List<WalletEntity> get suspendedWallets {
    return wallets.where((wallet) => wallet.suspended).toList();
  }

  /// Finds a wallet by its ID
  WalletEntity? findWallet(int walletId) {
    try {
      return wallets.firstWhere((wallet) => wallet.id == walletId);
    } catch (e) {
      return null;
    }
  }

  /// Creates a copy of this user with updated fields
  ///
  /// This is useful for updating user state while maintaining immutability
  UserEntity copyWith({
    int? id,
    String? name,
    String? lastName,
    String? nationalCode,
    String? mobile,
    String? email,
    UserStatus? status,
    DateTime? createdAt,
    List<WalletEntity>? wallets,
  }) {
    return UserEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      nationalCode: nationalCode ?? this.nationalCode,
      mobile: mobile ?? this.mobile,
      email: email ?? this.email,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      wallets: wallets ?? this.wallets,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserEntity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'UserEntity(id: $id, name: $fullName, email: $email, status: $status)';
  }
}

/// Enum representing possible user account statuses
///
/// **Usage:**
/// ```dart
/// if (user.status == UserStatus.active) {
///   // User can access features
/// } else if (user.status == UserStatus.suspended) {
///   // Show suspended message
/// }
/// ```
enum UserStatus {
  /// User account is active and can perform operations
  active('ACTIVE'),

  /// User account is inactive (may be temporary)
  inactive('INACTIVE'),

  /// User account is suspended (blocked)
  suspended('SUSPENDED'),

  /// User account is pending approval
  pending('PENDING');

  final String value;
  const UserStatus(this.value);

  /// Parses a string value to UserStatus enum
  static UserStatus fromString(String value) {
    return UserStatus.values.firstWhere(
      (status) => status.value == value.toUpperCase(),
      orElse: () => UserStatus.inactive,
    );
  }
}
