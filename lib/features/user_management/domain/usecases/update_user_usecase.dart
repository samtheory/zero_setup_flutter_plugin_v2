import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

/// Use case for updating user profile information
///
/// This use case encapsulates the business logic for updating
/// user profile fields such as name, email, phone, etc.
///
/// **Validation:** Should include business rules validation
/// **Single Responsibility:** Only handles user profile updates
///
/// **Usage Example:**
/// ```dart
/// final useCase = UpdateUserUseCase(repository);
/// 
/// final updatedUser = await useCase(
///   name: 'New Name',
///   email: 'newemail@example.com',
/// );
/// 
/// print('Updated: ${updatedUser.fullName}');
/// ```
class UpdateUserUseCase {
  final UserRepository repository;

  UpdateUserUseCase(this.repository);

  /// Executes the use case to update user profile
  ///
  /// All parameters are optional - only provided fields will be updated
  ///
  /// [name] - User's first name
  /// [lastName] - User's last name
  /// [nationalCode] - National ID number
  /// [mobile] - Phone number
  /// [email] - Email address
  ///
  /// Returns updated [UserEntity]
  /// Throws [Exception] on validation or network errors
  Future<UserEntity> call({
    String? name,
    String? lastName,
    String? nationalCode,
    String? mobile,
    String? email,
  }) async {
    // Build update map with only provided fields
    final updates = <String, dynamic>{};
    
    if (name != null) {
      _validateName(name);
      updates['name'] = name;
    }
    if (lastName != null) {
      _validateName(lastName);
      updates['lastName'] = lastName;
    }
    if (nationalCode != null) {
      _validateNationalCode(nationalCode);
      updates['nationalCode'] = nationalCode;
    }
    if (mobile != null) {
      _validateMobile(mobile);
      updates['mobile'] = mobile;
    }
    if (email != null) {
      _validateEmail(email);
      updates['email'] = email;
    }

    if (updates.isEmpty) {
      throw Exception('No fields to update');
    }

    return await repository.updateUser(updates);
  }

  /// Validates name fields (first name, last name)
  void _validateName(String name) {
    if (name.trim().isEmpty) {
      throw Exception('Name cannot be empty');
    }
    if (name.length < 2) {
      throw Exception('Name must be at least 2 characters');
    }
  }

  /// Validates national code format
  void _validateNationalCode(String code) {
    if (code.trim().isEmpty) {
      throw Exception('National code cannot be empty');
    }
    // Add specific validation rules based on your country's format
    if (code.length != 10 || !RegExp(r'^\d+$').hasMatch(code)) {
      throw Exception('Invalid national code format');
    }
  }

  /// Validates mobile phone number
  void _validateMobile(String mobile) {
    if (mobile.trim().isEmpty) {
      throw Exception('Mobile number cannot be empty');
    }
    // Basic validation - adjust regex based on your requirements
    if (!RegExp(r'^\+?[\d\s-]+$').hasMatch(mobile)) {
      throw Exception('Invalid mobile number format');
    }
  }

  /// Validates email address
  void _validateEmail(String email) {
    if (email.trim().isEmpty) {
      throw Exception('Email cannot be empty');
    }
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(email)) {
      throw Exception('Invalid email format');
    }
  }
}
