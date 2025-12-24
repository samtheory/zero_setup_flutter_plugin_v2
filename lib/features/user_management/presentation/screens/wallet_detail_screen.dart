import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../providers/wallet_notifier.dart';

/// Wallet Detail Screen
///
/// Displays detailed information about a specific wallet and allows
/// adding income or expense transactions to update the balance.
///
/// **Features:**
/// - Displays wallet balance, limits, and fees
/// - Add income button with dialog
/// - Add expense button with dialog
/// - Transaction validation
/// - Real-time balance updates
/// - Error handling
///
/// **Usage Example:**
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(
///     builder: (context) => WalletDetailScreen(walletId: 101),
///   ),
/// );
/// ```
class WalletDetailScreen extends ConsumerWidget {
  final int walletId;

  const WalletDetailScreen({super.key, required this.walletId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final walletAsync = ref.watch(walletNotifierProvider(walletId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallet Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(walletNotifierProvider(walletId).notifier).refresh();
            },
          ),
        ],
      ),
      body: walletAsync.when(
        data: (wallet) => RefreshIndicator(
          onRefresh: () async {
            await ref.read(walletNotifierProvider(walletId).notifier).refresh();
          },
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              // Wallet Info Card
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: wallet.suspended ? Colors.red : Colors.green,
                            child: Icon(
                              wallet.suspended ? Icons.block : Icons.account_balance_wallet,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(wallet.title, style: Theme.of(context).textTheme.headlineSmall),
                                const SizedBox(height: 4),
                                if (wallet.suspended)
                                  const Text(
                                    'SUSPENDED',
                                    style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                                  )
                                else
                                  const Text(
                                    'ACTIVE',
                                    style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 32),
                      // Balance
                      Center(
                        child: Column(
                          children: [
                            Text(
                              'Current Balance',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _formatCurrency(wallet.balance),
                              style: Theme.of(
                                context,
                              ).textTheme.headlineLarge?.copyWith(color: Colors.green, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const Divider(height: 32),
                      // Wallet details
                      _buildDetailRow('Wallet ID', '#${wallet.id}'),
                      _buildDetailRow('Company ID', '#${wallet.companyId}'),
                      _buildDetailRow('Transaction Limit', _formatCurrency(wallet.transactionLimit)),
                      _buildDetailRow('Normal Fee', '${wallet.feePercentForNormal}%'),
                      _buildDetailRow('Fast Fee', '${wallet.feePercentForFast}%'),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Action Buttons
              if (!wallet.suspended) ...[
                // Add Income Button
                ElevatedButton.icon(
                  onPressed: () {
                    _showAddIncomeDialog(context, ref, wallet.title);
                  },
                  icon: const Icon(Icons.add_circle),
                  label: const Text('Add Income'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),

                const SizedBox(height: 12),

                // Add Expense Button
                OutlinedButton.icon(
                  onPressed: () {
                    _showAddExpenseDialog(context, ref, wallet.title, wallet.balance);
                  },
                  icon: const Icon(Icons.remove_circle),
                  label: const Text('Add Expense'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ] else
                Card(
                  color: Colors.red[50],
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Icon(Icons.warning, color: Colors.red),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'This wallet is suspended. Transactions are not allowed.',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
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
                Text('Failed to load wallet', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                Text(error.toString(), textAlign: TextAlign.center),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () {
                    ref.read(walletNotifierProvider(walletId).notifier).refresh();
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

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
          ),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  String _formatCurrency(double amount) {
    return '${amount.toStringAsFixed(0)} ﷼';
  }

  void _showAddIncomeDialog(BuildContext context, WidgetRef ref, String walletTitle) {
    final amountController = TextEditingController();
    final descriptionController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Income'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: amountController,
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  prefixIcon: Icon(Icons.attach_money),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter amount';
                  }
                  final amount = double.tryParse(value);
                  if (amount == null || amount <= 0) {
                    return 'Please enter a valid amount';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description (optional)',
                  prefixIcon: Icon(Icons.description),
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                Navigator.pop(context);
                await _addIncome(
                  context,
                  ref,
                  double.parse(amountController.text),
                  descriptionController.text.isEmpty ? null : descriptionController.text,
                );
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showAddExpenseDialog(BuildContext context, WidgetRef ref, String walletTitle, double currentBalance) {
    final amountController = TextEditingController();
    final descriptionController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Expense'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Available: ${_formatCurrency(currentBalance)}', style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 16),
              TextFormField(
                controller: amountController,
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  prefixIcon: Icon(Icons.attach_money),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter amount';
                  }
                  final amount = double.tryParse(value);
                  if (amount == null || amount <= 0) {
                    return 'Please enter a valid amount';
                  }
                  if (amount > currentBalance) {
                    return 'Insufficient balance';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description (optional)',
                  prefixIcon: Icon(Icons.description),
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                Navigator.pop(context);
                await _addExpense(
                  context,
                  ref,
                  double.parse(amountController.text),
                  descriptionController.text.isEmpty ? null : descriptionController.text,
                );
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  Future<void> _addIncome(BuildContext context, WidgetRef ref, double amount, String? description) async {
    try {
      await ref.read(walletNotifierProvider(walletId).notifier).addIncome(amount: amount, description: description);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Income of ${_formatCurrency(amount)} added successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to add income: $e'), backgroundColor: Colors.red));
      }
    }
  }

  Future<void> _addExpense(BuildContext context, WidgetRef ref, double amount, String? description) async {
    try {
      await ref.read(walletNotifierProvider(walletId).notifier).addExpense(amount: amount, description: description);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Expense of ${_formatCurrency(amount)} recorded successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to add expense: $e'), backgroundColor: Colors.red));
      }
    }
  }
}
