// ⭐ (مغز Navigation)

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
    // 🛡️ Auth Guard
    redirect: (context, state) {
      // final isLoggedIn = authState.isAuthenticated;
      // final isLoggingIn = state.matchedLocation == Routes.login;

      // اگه لاگین نیست و داره میره جایی غیر از Login → برو Login
      // if (!isLoggedIn && !isLoggingIn) {
      //   return Routes.login;
      // }

      // اگه لاگینه و داره میره Login → برو Home
      // if (isLoggedIn && isLoggingIn) {
      //   return Routes.home;
      // }

      // در غیر این صورت، اجازه بده
      return null;
    },

    routes: [
      // 🔐 Login Route (بدون Shell)
      GoRoute(path: Routes.root, builder: (context, state) => const RootScreen()),
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
