# User Management Feature

A complete, production-ready user/employee management feature with wallet support, built using Clean Architecture principles and Flutter/Riverpod.

## 📋 Table of Contents

- [Overview](#overview)
- [Architecture](#architecture)
- [Features](#features)
- [API Integration](#api-integration)
- [Installation](#installation)
- [Usage](#usage)
- [Code Structure](#code-structure)
- [State Management](#state-management)
- [Customization](#customization)
- [Testing](#testing)

## 🎯 Overview

This feature provides a complete CRUD implementation for managing user profiles and their associated wallets. It demonstrates best practices in Flutter development, including:

- **Clean Architecture** (Domain, Data, Presentation layers)
- **Repository Pattern** for data abstraction
- **Use Cases** for business logic encapsulation
- **Riverpod** for state management
- **Freezed** for immutable data models
- **Dio** for HTTP networking

## 🏗️ Architecture

The feature follows Clean Architecture with three distinct layers:

```
user_management/
├── domain/           # Business logic & entities
│   ├── entities/    # Pure Dart domain models
│   ├── repositories/  # Repository interfaces
│   └── usecases/    # Business use cases
├── data/            # Data layer
│   ├── models/      # DTOs with JSON serialization
│   ├── datasources/ # API clients
│   └── repositories/ # Repository implementations
└── presentation/    # UI layer
    ├── providers/   # Riverpod state management
    └── screens/     # UI screens & widgets
```

### Layer Responsibilities

**Domain Layer** (Framework-independent)
- Defines business entities (User, Wallet)
- Declares repository interfaces
- Implements business logic in use cases

**Data Layer**
- Implements repository interfaces
- Handles API communication via Dio
- Transforms API responses to domain entities

**Presentation Layer**
- Manages UI state with Riverpod
- Renders screens and widgets
- Handles user interactions

## ✨ Features

### User Profile Management
- ✅ View complete user profile with personal information
- ✅ Edit user details (name, email, phone, national code)
- ✅ Input validation with error messages
- ✅ Real-time profile updates
- ✅ Pull-to-refresh support

### Wallet Management
- ✅ Display list of user wallets
- ✅ View detailed wallet information
- ✅ Add income transactions
- ✅ Add expense transactions
- ✅ Balance validation
- ✅ Transaction limits enforcement
- ✅ Suspended wallet detection

### State Management
- ✅ AsyncNotifier for user state
- ✅ FamilyNotifier for individual wallet state
- ✅ Automatic state synchronization
- ✅ Loading & error states
- ✅ Optimistic updates

## 🔌 API Integration

### Base URL
```dart
http://localhost:3080
```

### Endpoints

#### Get Current User
```http
GET /me
```
Returns user profile with nested wallets array.

#### Update User Profile
```http
PATCH /me
Content-Type: application/json

{
  "name": "NewName",
  "email": "newemail@example.com"
}
```

#### Update Wallet Balance
```http
PATCH /wallets/{walletId}/balance
Content-Type: application/json

{
  "amount": 50000,
  "type": "income",
  "description": "Salary deposit"
}
```

### Sample API Response

```json
{
  "id": 445,
  "name": "Ali",
  "lastName": "Ahmadi",
  "nationalCode": "1234567890",
  "mobile": "+989121234567",
  "email": "ali.ahmadi@example.com",
  "status": "ACTIVE",
  "createdAt": "2024-01-15T10:45:32Z",
  "wallets": [
    {
      "id": 101,
      "companyId": 12,
      "employeeId": 445,
      "balance": 325000,
      "title": "Main Wallet",
      "transactionLimit": 500000,
      "feePercentForNormal": 2,
      "feePercentForFast": 5,
      "suspended": false
    }
  ]
}
```

## 📦 Installation

### 1. Dependencies

Add these to your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_riverpod: ^2.5.1
  freezed_annotation: ^2.4.1
  dio: ^5.4.0

dev_dependencies:
  build_runner: ^2.4.8
  freezed: ^2.4.7
  json_serializable: ^6.7.1
```

### 2. Generate Code

Run code generation for Freezed models:

```bash
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

### 3. Configure Base URL

Update the base URL in `user_providers.dart`:

```dart
final dioProvider = Provider<Dio>((ref) {
  return Dio(
    BaseOptions(
      baseUrl: 'YOUR_API_BASE_URL', // Change this
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );
});
```

## 🚀 Usage

### Basic Navigation

```dart
// Navigate to user profile screen
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const UserProfileScreen(),
  ),
);
```

### In Your App

1. **Wrap your app with ProviderScope:**

```dart
void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}
```

2. **Use the feature in your app:**

```dart
class MyHomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const UserProfileScreen(),
              ),
            );
          },
          child: const Text('View Profile'),
        ),
      ),
    );
  }
}
```

### Accessing User State Anywhere

```dart
class AnyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userNotifierProvider);
    
    return userAsync.when(
      data: (user) => Text('Hello, ${user.name}!'),
      loading: () => CircularProgressIndicator(),
      error: (error, _) => Text('Error: $error'),
    );
  }
}
```

### Updating User Profile

```dart
// From anywhere in your app
await ref.read(userNotifierProvider.notifier).updateUserProfile(
  name: 'New Name',
  email: 'newemail@example.com',
);
```

### Working with Wallets

```dart
// Watch a specific wallet
final walletAsync = ref.watch(walletNotifierProvider(walletId));

// Add income
await ref.read(walletNotifierProvider(walletId).notifier).addIncome(
  amount: 50000,
  description: 'Salary',
);

// Add expense
await ref.read(walletNotifierProvider(walletId).notifier).addExpense(
  amount: 10000,
  description: 'Purchase',
);
```

## 📁 Code Structure

```
lib/features/user_management/
│
├── domain/
│   ├── entities/
│   │   ├── user_entity.dart              # User domain model
│   │   └── wallet_entity.dart            # Wallet domain model
│   ├── repositories/
│   │   └── user_repository.dart          # Repository interface
│   └── usecases/
│       ├── get_current_user_usecase.dart
│       ├── update_user_usecase.dart
│       └── update_wallet_balance_usecase.dart
│
├── data/
│   ├── models/
│   │   ├── user_model.dart               # User DTO with JSON
│   │   └── wallet_model.dart             # Wallet DTO with JSON
│   ├── datasources/
│   │   └── user_remote_datasource.dart   # API client
│   └── repositories/
│       └── user_repository_impl.dart     # Repository implementation
│
└── presentation/
    ├── providers/
    │   ├── user_providers.dart           # Dependency injection
    │   ├── user_notifier.dart            # User AsyncNotifier
    │   └── wallet_notifier.dart          # Wallet FamilyNotifier
    └── screens/
        ├── user_profile_screen.dart      # Profile view
        ├── user_edit_screen.dart         # Profile editor
        └── wallet_detail_screen.dart     # Wallet details & transactions
```

## 🔄 State Management

### User State (AsyncNotifier)

The `UserNotifier` manages the global user state:

```dart
final userNotifierProvider = AsyncNotifierProvider<UserNotifier, UserEntity>(
  () => UserNotifier(),
);
```

**Features:**
- Loads user data on initialization
- Handles profile updates
- Maintains wallet list
- Provides refresh capability

### Wallet State (FamilyNotifier)

The `WalletNotifier` manages individual wallet states:

```dart
final walletNotifierProvider = AsyncNotifierProvider.family<
  WalletNotifier,
  WalletEntity,
  int
>(() => WalletNotifier());
```

**Features:**
- Per-wallet state isolation
- Income/expense operations
- Balance validation
- Automatic sync with user state

## 🎨 Customization

### Change Currency Symbol

Edit the `_formatCurrency` method in screens:

```dart
String _formatCurrency(double amount) {
  return '\$${amount.toStringAsFixed(2)}'; // Changed to dollar
}
```

### Add Authentication Headers

Modify `dioProvider` in `user_providers.dart`:

```dart
final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(BaseOptions(baseUrl: 'http://localhost:3080'));
  
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers['Authorization'] = 'Bearer YOUR_TOKEN';
        return handler.next(options);
      },
    ),
  );
  
  return dio;
});
```

### Customize Validation Rules

Edit validation methods in `UpdateUserUseCase`:

```dart
void _validateNationalCode(String code) {
  // Add your country-specific validation
  if (code.length != 10) {
    throw Exception('National code must be 10 digits');
  }
}
```

## 🧪 Testing

### Unit Tests Example

```dart
test('UserEntity calculates total balance correctly', () {
  final user = UserEntity(
    id: 1,
    name: 'Test',
    wallets: [
      WalletEntity(balance: 1000, ...),
      WalletEntity(balance: 2000, ...),
    ],
  );
  
  expect(user.totalBalance, 3000);
});
```

### Widget Tests Example

```dart
testWidgets('UserProfileScreen displays user name', (tester) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        userNotifierProvider.overrideWith(() => MockUserNotifier()),
      ],
      child: MaterialApp(home: UserProfileScreen()),
    ),
  );
  
  expect(find.text('John Doe'), findsOneWidget);
});
```

## 🔧 Troubleshooting

### Code Generation Issues

```bash
# Clean and regenerate
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

### API Connection Issues

1. Ensure backend is running on `http://localhost:3080`
2. Check Dio interceptor logs
3. Verify CORS settings on backend
4. Test with Postman/curl first

### State Not Updating

1. Ensure you're using `ref.read()` for mutations
2. Check that AsyncNotifier is properly rebuilding
3. Verify API returns updated data
4. Check for errors in console

## 📝 License

This is an example feature for educational purposes. Feel free to use and modify as needed.

## 🤝 Contributing

This feature demonstrates best practices. Feel free to adapt it to your needs:

1. Copy the `user_management` folder to your project
2. Run code generation
3. Update API endpoints and models
4. Customize UI as needed

## 📚 Additional Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Riverpod Documentation](https://riverpod.dev)
- [Freezed Package](https://pub.dev/packages/freezed)
- [Dio HTTP Client](https://pub.dev/packages/dio)
- [Clean Architecture in Flutter](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)

---

**Built with ❤️ using Flutter and Clean Architecture**
