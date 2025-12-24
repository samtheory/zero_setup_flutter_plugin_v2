import 'package:dio/dio.dart';
import '../models/user_model.dart';
import '../models/wallet_model.dart';

/// Abstract interface for user-related remote API calls
///
/// This datasource interface defines the contract for making
/// HTTP requests to the user management API endpoints.
///
/// **Usage Example:**
/// ```dart
/// class UserRepositoryImpl implements UserRepository {
///   final UserRemoteDataSource dataSource;
///   
///   Future<UserEntity> getUser() async {
///     final model = await dataSource.fetchCurrentUser();
///     return model.toEntity();
///   }
/// }
/// ```
abstract class UserRemoteDataSource {
  /// Fetches current user data from GET /me endpoint
  Future<UserModel> fetchCurrentUser();

  /// Updates user profile via PATCH /me endpoint
  ///
  /// [updates] contains field names and new values
  Future<UserModel> updateUser(Map<String, dynamic> updates);

  /// Updates wallet balance via API
  ///
  /// Specific endpoint may vary (could be PATCH /wallets/{id}/balance)
  Future<WalletModel> updateWalletBalance({
    required int walletId,
    required double amount,
    required String transactionType,
    String? description,
  });
}

/// Remote datasource implementation using Dio HTTP client
///
/// This class handles all HTTP requests to the user management API.
/// It includes error handling, request/response transformation,
/// and proper HTTP method usage (GET, PATCH, PUT, POST).
///
/// **Configuration:**
/// Base URL should be configured when creating Dio instance.
///
/// **Usage Example:**
/// ```dart
/// final dio = Dio(BaseOptions(
///   baseUrl: 'http://localhost:3080',
///   headers: {'Content-Type': 'application/json'},
/// ));
///
/// final dataSource = UserRemoteDataSourceImpl(dio: dio);
/// final user = await dataSource.fetchCurrentUser();
/// ```
class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final Dio dio;

  /// Base endpoint for user operations
  static const String _meEndpoint = '/me';

  /// Base endpoint for wallet operations
  static const String _walletsEndpoint = '/wallets';

  UserRemoteDataSourceImpl({required this.dio});

  @override
  Future<UserModel> fetchCurrentUser() async {
    try {
      final response = await dio.get(_meEndpoint);
      
      if (response.statusCode == 200 && response.data != null) {
        return UserModel.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw Exception('Failed to fetch user: Invalid response');
      }
    } catch (e) {
      rethrow; // Let repository handle the error
    }
  }

  @override
  Future<UserModel> updateUser(Map<String, dynamic> updates) async {
    try {
      // Using PATCH for partial updates (RESTful convention)
      final response = await dio.patch(
        _meEndpoint,
        data: updates,
      );

      if (response.statusCode == 200 && response.data != null) {
        return UserModel.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw Exception('Failed to update user: Invalid response');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<WalletModel> updateWalletBalance({
    required int walletId,
    required double amount,
    required String transactionType,
    String? description,
  }) async {
    try {
      // Endpoint could be: PATCH /wallets/{id}/balance or POST /wallets/{id}/transactions
      // Adjust based on your actual API design
      final response = await dio.patch(
        '$_walletsEndpoint/$walletId/balance',
        data: {
          'amount': amount,
          'type': transactionType,
          if (description != null) 'description': description,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        return WalletModel.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw Exception('Failed to update wallet balance: Invalid response');
      }
    } catch (e) {
      rethrow;
    }
  }
}
