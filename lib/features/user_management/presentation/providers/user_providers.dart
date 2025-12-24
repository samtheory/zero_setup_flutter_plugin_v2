import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../data/datasources/user_remote_datasource.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../../domain/repositories/user_repository.dart';
import '../../domain/usecases/get_current_user_usecase.dart';
import '../../domain/usecases/update_user_usecase.dart';
import '../../domain/usecases/update_wallet_balance_usecase.dart';

/// Provider for Dio HTTP client
///
/// Configure base URL and other options here
///
/// **Usage:**
/// ```dart
/// final dio = ref.watch(dioProvider);
/// ```
final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'http://10.0.2.2:3080',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
    ),
  );

  // Add interceptors for logging, auth, etc.
  dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true, error: true));

  return dio;
});

/// Provider for user remote data source
///
/// **Usage:**
/// ```dart
/// final dataSource = ref.watch(userRemoteDataSourceProvider);
/// ```
final userRemoteDataSourceProvider = Provider<UserRemoteDataSource>((ref) {
  final dio = ref.watch(dioProvider);
  return UserRemoteDataSourceImpl(dio: dio);
});

/// Provider for user repository
///
/// **Usage:**
/// ```dart
/// final repository = ref.watch(userRepositoryProvider);
/// ```
final userRepositoryProvider = Provider<UserRepository>((ref) {
  final dataSource = ref.watch(userRemoteDataSourceProvider);
  return UserRepositoryImpl(remoteDataSource: dataSource);
});

/// Provider for GetCurrentUser use case
///
/// **Usage:**
/// ```dart
/// final useCase = ref.watch(getCurrentUserUseCaseProvider);
/// final user = await useCase();
/// ```
final getCurrentUserUseCaseProvider = Provider<GetCurrentUserUseCase>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  return GetCurrentUserUseCase(repository);
});

/// Provider for UpdateUser use case
///
/// **Usage:**
/// ```dart
/// final useCase = ref.watch(updateUserUseCaseProvider);
/// await useCase(name: 'New Name');
/// ```
final updateUserUseCaseProvider = Provider<UpdateUserUseCase>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  return UpdateUserUseCase(repository);
});

/// Provider for UpdateWalletBalance use case
///
/// **Usage:**
/// ```dart
/// final useCase = ref.watch(updateWalletBalanceUseCaseProvider);
/// await useCase(walletId: 101, amount: 5000, isIncome: true);
/// ```
final updateWalletBalanceUseCaseProvider = Provider<UpdateWalletBalanceUseCase>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  return UpdateWalletBalanceUseCase(repository);
});
