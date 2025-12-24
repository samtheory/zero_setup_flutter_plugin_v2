import 'package:dio/dio.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/entities/wallet_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_remote_datasource.dart';

/// Implementation of UserRepository using remote data source
///
/// This class implements the repository interface and coordinates
/// data operations between the domain layer and remote API.
///
/// **Usage Example:**
/// ```dart
/// final dio = Dio();
/// final dataSource = UserRemoteDataSourceImpl(dio: dio);
/// final repository = UserRepositoryImpl(remoteDataSource: dataSource);
///
/// // Use in use cases or providers
/// final user = await repository.getCurrentUser();
/// ```
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<UserEntity> getCurrentUser() async {
    try {
      final userModel = await remoteDataSource.fetchCurrentUser();
      return userModel.toEntity();
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Failed to fetch user data: $e');
    }
  }

  @override
  Future<UserEntity> updateUser(Map<String, dynamic> updates) async {
    try {
      final userModel = await remoteDataSource.updateUser(updates);
      return userModel.toEntity();
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }

  @override
  Future<WalletEntity> updateWalletBalance({
    required int walletId,
    required double amount,
    required String transactionType,
    String? description,
  }) async {
    try {
      final walletModel = await remoteDataSource.updateWalletBalance(
        walletId: walletId,
        amount: amount,
        transactionType: transactionType,
        description: description,
      );
      return walletModel.toEntity();
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Failed to update wallet balance: $e');
    }
  }

  @override
  Future<UserEntity> refreshUser() async {
    // For now, same as getCurrentUser, but could implement caching logic
    return getCurrentUser();
  }

  /// Handles Dio errors and converts them to meaningful exceptions
  Exception _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Exception('Connection timeout. Please check your internet connection.');
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final message = error.response?.data?['message'] ?? 'Server error';
        return Exception('Server error ($statusCode): $message');
      case DioExceptionType.cancel:
        return Exception('Request cancelled');
      default:
        return Exception('Network error: ${error.message}');
    }
  }
}
