/// Example Integration for User Management Feature
///
/// This file demonstrates how to integrate the user_management feature
/// into your Flutter app. Copy the relevant parts to your app's main.dart
/// or other appropriate files.
///
/// **Quick Start:**
/// 1. Ensure ProviderScope wraps your MaterialApp
/// 2. Navigate to UserProfileScreen from anywhere in your app
/// 3. Access user state using userNotifierProvider
///
/// **Example Usage:**
/// ```dart
/// // In main.dart
/// void main() {
///   runApp(const ProviderScope(child: MyApp()));
/// }
///
/// // Navigate to profile
/// Navigator.push(
///   context,
///   MaterialPageRoute(builder: (context) => const UserProfileScreen()),
/// );
/// ```

import 'package:app_test_plugin/features/user_management/presentation/providers/user_notifier.dart';
import 'package:app_test_plugin/features/user_management/presentation/screens/user_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Example: Main app entry point with ProviderScope
///
/// ProviderScope is required for Riverpod to work
void main() {
  runApp(
    const ProviderScope(
      child: UserManagementExampleApp(),
    ),
  );
}

/// Example: App widget
class UserManagementExampleApp extends StatelessWidget {
  const UserManagementExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Management Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const ExampleHomePage(),
    );
  }
}

/// Example: Home page with navigation to user profile
class ExampleHomePage extends ConsumerWidget {
  const ExampleHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Management Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Example 1: Simple navigation button
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserProfileScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.person),
              label: const Text('View My Profile'),
            ),

            const SizedBox(height: 20),

            // Example 2: Display user info inline
            const UserInfoWidget(),

            const SizedBox(height: 20),

            // Example 3: Quick actions
            const QuickActionsWidget(),
          ],
        ),
      ),
    );
  }
}

/// Example: Widget that displays user info using the provider
class UserInfoWidget extends ConsumerWidget {
  const UserInfoWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userNotifierProvider);

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: userAsync.when(
          data: (user) => Column(
            children: [
              CircleAvatar(
                radius: 40,
                child: Text(
                  user.name[0] + user.lastName[0],
                  style: const TextStyle(fontSize: 32),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                user.fullName,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                user.email,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Total Balance: ${_formatCurrency(user.totalBalance)}',
                style: const TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${user.wallets.length} wallet(s)',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          loading: () => const CircularProgressIndicator(),
          error: (error, _) => Column(
            children: [
              const Icon(Icons.error, color: Colors.red),
              const SizedBox(height: 8),
              Text('Error: ${error.toString()}'),
            ],
          ),
        ),
      ),
    );
  }

  String _formatCurrency(double amount) {
    return '${amount.toStringAsFixed(0)} ﷼';
  }
}

/// Example: Quick actions widget
class QuickActionsWidget extends ConsumerWidget {
  const QuickActionsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Quick Actions',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            
            // Refresh user data
            ElevatedButton.icon(
              onPressed: () {
                ref.read(userNotifierProvider.notifier).refresh();
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Refresh User Data'),
            ),

            const SizedBox(height: 8),

            // View full profile
            OutlinedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserProfileScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.account_circle),
              label: const Text('View Full Profile'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Example: Using user state in business logic
class UserBusinessLogicExample {
  /// Example: Check if user can make a purchase
  static bool canMakePurchase(WidgetRef ref, double amount) {
    final userAsync = ref.read(userNotifierProvider);

    return userAsync.maybeWhen(
      data: (user) {
        // Check if user has enough balance in active wallets
        final activeWallets = user.activeWallets;
        if (activeWallets.isEmpty) return false;

        // Check if any active wallet can process the transaction
        return activeWallets.any((wallet) => wallet.canProcessTransaction(amount));
      },
      orElse: () => false,
    );
  }

  /// Example: Get user's primary wallet
  static int? getPrimaryWalletId(WidgetRef ref) {
    final userAsync = ref.read(userNotifierProvider);

    return userAsync.maybeWhen(
      data: (user) {
        final activeWallets = user.activeWallets;
        if (activeWallets.isEmpty) return null;
        
        // Return first active wallet (or implement your logic)
        return activeWallets.first.id;
      },
      orElse: () => null,
    );
  }

  /// Example: Update user email with validation
  static Future<void> updateUserEmail(WidgetRef ref, String newEmail) async {
    try {
      await ref.read(userNotifierProvider.notifier).updateUserProfile(
            email: newEmail,
          );
      // Success
    } catch (e) {
      // Handle error
      rethrow;
    }
  }
}

/// Example: Custom hook for user data (using flutter_hooks if available)
///
/// ```dart
/// final user = useUserData();
/// if (user != null) {
///   print(user.name);
/// }
/// ```
/// 
/// Note: This requires flutter_hooks package
// User? useUserData() {
//   final userAsync = useProvider(userNotifierProvider);
//   return userAsync.maybeWhen(
//     data: (user) => user,
//     orElse: () => null,
//   );
// }

/// Example: Integration with routing
///
/// If you're using go_router or similar:
///
/// ```dart
/// final router = GoRouter(
///   routes: [
///     GoRoute(
///       path: '/profile',
///       builder: (context, state) => const UserProfileScreen(),
///     ),
///     GoRoute(
///       path: '/wallet/:id',
///       builder: (context, state) {
///         final walletId = int.parse(state.pathParameters['id']!);
///         return WalletDetailScreen(walletId: walletId);
///       },
///     ),
///   ],
/// );
/// ```

/// Example: App bar with user info
class AppBarWithUserInfo extends ConsumerWidget implements PreferredSizeWidget {
  const AppBarWithUserInfo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userNotifierProvider);

    return AppBar(
      title: const Text('My App'),
      actions: [
        userAsync.when(
          data: (user) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserProfileScreen(),
                  ),
                );
              },
              child: Row(
                children: [
                  Text(
                    user.name,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    radius: 16,
                    child: Text(user.name[0]),
                  ),
                ],
              ),
            ),
          ),
          loading: () => const Padding(
            padding: EdgeInsets.all(12.0),
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
          error: (_, __) => IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UserProfileScreen(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
