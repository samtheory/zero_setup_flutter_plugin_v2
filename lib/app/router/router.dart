// ⭐ (مغز Navigation)

import 'package:app_test_plugin/features/home/presentation/screens/home_screen.dart';
import 'package:app_test_plugin/features/testing/presentation/screens/root_screen.dart';
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
    initialLocation: Routes.root,
    debugLogDiagnostics: true, // برای دیباگ - توی Production غیرفعال کن

    // 🛡️ Auth Guard (uncomment when auth is implemented)
    // redirect: (context, state) {
    //   // Auth logic here
    //   return null;
    // },
    routes: [
      // 🔐 Login Route (بدون Shell)
      GoRoute(path: Routes.root, builder: (context, state) => const RootScreen()),
      GoRoute(path: Routes.home, builder: (context, state) => const HomeScreen()),
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
            ElevatedButton(onPressed: () => context.go(Routes.root), child: const Text('برگرد به خانه')),
          ],
        ),
      ),
    ),
  );
});
