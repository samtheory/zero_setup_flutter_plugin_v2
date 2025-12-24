import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../providers/user_notifier.dart';
import 'user_edit_screen.dart';
import 'wallet_detail_screen.dart';

/// User Profile Screen
///
/// Displays the current user's profile information and list of wallets.
/// Provides navigation to edit profile and view wallet details.
///
/// **Features:**
/// - Displays user personal information
/// - Shows list of all wallets with balances
/// - Edit profile button
/// - Pull-to-refresh functionality
/// - Error handling with retry option
///
/// **Usage Example:**
/// ```dart
/// // Navigate to profile screen
/// Navigator.push(
///   context,
///   MaterialPageRoute(
///     builder: (context) => const UserProfileScreen(),
///   ),
/// );
/// ```
class UserProfileScreen extends ConsumerWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        actions: [
          // Refresh button
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(userNotifierProvider.notifier).refresh();
            },
          ),
        ],
      ),
      body: userAsync.when(
        data: (user) => RefreshIndicator(
          onRefresh: () async {
            await ref.read(userNotifierProvider.notifier).refresh();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Card
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Personal Information', style: Theme.of(context).textTheme.titleLarge),
                            // Edit button
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const UserEditScreen()),
                                );
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildInfoRow('Name', user.fullName),
                        _buildInfoRow('Email', user.email),
                        _buildInfoRow('Mobile', user.mobile),
                        _buildInfoRow('National Code', user.nationalCode),
                        _buildInfoRow('Status', user.status.value),
                        _buildInfoRow('Member Since', _formatDate(user.createdAt)),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Wallets Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('My Wallets', style: Theme.of(context).textTheme.titleLarge),
                    Text(
                      'Total: ${_formatCurrency(user.totalBalance)}',
                      style: Theme.of(
                        context,
                      ).textTheme.titleMedium?.copyWith(color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Wallets List
                if (user.wallets.isEmpty)
                  const Center(
                    child: Padding(padding: EdgeInsets.all(32.0), child: Text('No wallets available')),
                  )
                else
                  ...user.wallets.map(
                    (wallet) => Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: wallet.suspended ? Colors.red : Colors.green,
                          child: Icon(
                            wallet.suspended ? Icons.block : Icons.account_balance_wallet,
                            color: Colors.white,
                          ),
                        ),
                        title: Text(wallet.title),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Balance: ${_formatCurrency(wallet.balance)}'),
                            if (wallet.suspended)
                              const Text(
                                'SUSPENDED',
                                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                              ),
                          ],
                        ),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => WalletDetailScreen(walletId: wallet.id)),
                          );
                        },
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
                const SizedBox(height: 16),
                Text('Failed to load profile', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                Text(error.toString(), textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () {
                    ref.read(userNotifierProvider.notifier).refresh();
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Builds an information row with label and value
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  /// Formats currency amount
  String _formatCurrency(double amount) {
    return '${amount.toStringAsFixed(0)} ﷼'; // Using Rial symbol
  }

  /// Formats date
  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
