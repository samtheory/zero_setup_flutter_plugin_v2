// ⭐ (مغز Navigation)

import 'package:app_test_plugin/features/ex_notifier/presentation/screen/normal_notifier_screen.dart';
import 'package:app_test_plugin/features/home/presentation/screens/home_screen.dart';
import 'package:app_test_plugin/features/user_management/presentation/screens/user_profile_screen.dart';
import 'package:app_test_plugin/features/user_management/presentation/screens/user_edit_screen.dart';
import 'package:app_test_plugin/features/user_management/presentation/screens/wallet_detail_screen.dart';
import 'package:app_test_plugin/features/map_feature/presentation/screens/map_screen.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'routes.dart';

/// کلید Navigator برای refresh
final _rootNavigatorKey = GlobalKey<NavigatorState>();
// final _shellNavigatorKey = GlobalKey<NavigatorState>();

/// Router Provider
final routerProvider = Provider<GoRouter>((ref) {
  // وقتی Auth تغییر کنه، Router خودکار refresh میشه
  // final authState = ref.watch(authProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: Routes.home,
    debugLogDiagnostics: true, // برای دیباگ - توی Production غیرفعال کن
    // 🛡️ Auth Guard (uncomment when auth is implemented)
    // redirect: (context, state) {
    //   // Auth logic here
    //   return null;
    // },
    routes: [
      GoRoute(path: Routes.home, builder: (context, state) => const HomeScreen()),

      // example of notifier screens
      GoRoute(path: Routes.normalNotifier, builder: (context, state) => const NormalNotifierScreen()),
      GoRoute(path: Routes.mapScreen, builder: (context, state) => const MapScreen()),

      // User Management Routes
      GoRoute(path: Routes.userProfile, builder: (context, state) => const UserProfileScreen()),
      GoRoute(path: Routes.userEdit, builder: (context, state) => const UserEditScreen()),
      GoRoute(
        path: '${Routes.walletDetail}/:walletId',
        builder: (context, state) {
          final walletId = int.tryParse(state.pathParameters['walletId'] ?? '');
          if (walletId == null) {
            // Handle invalid walletId - redirect to user profile
            return const UserProfileScreen();
          }
          return WalletDetailScreen(walletId: walletId);
        },
      ),

      // Map Feature Routes
      GoRoute(path: Routes.map, builder: (context, state) => const MapScreen()),
    ],

    // 404 Page
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text('۴۰۴ - صفحه پیدا نشد!', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text('مسیر: ${state.matchedLocation}'),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: () => context.go(Routes.home), child: const Text('برگرد به خانه')),
          ],
        ),
      ),
    ),
  );
});
