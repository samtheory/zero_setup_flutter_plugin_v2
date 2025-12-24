import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../providers/user_notifier.dart';

/// User Edit Screen
///
/// Allows users to edit their profile information.
/// Validates input and updates the user profile via API.
///
/// **Features:**
/// - Editable fields for name, email, phone, national code
/// - Input validation
/// - Loading state during update
/// - Error handling with user feedback
/// - Auto-populates current values
///
/// **Usage Example:**
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(
///     builder: (context) => const UserEditScreen(),
///   ),
/// );
/// ```
class UserEditScreen extends ConsumerStatefulWidget {
  const UserEditScreen({super.key});

  @override
  ConsumerState<UserEditScreen> createState() => _UserEditScreenState();
}

class _UserEditScreenState extends ConsumerState<UserEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _nationalCodeController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Populate fields with current user data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadUserData();
    });
  }

  void _loadUserData() {
    final userAsync = ref.read(userNotifierProvider);
    userAsync.whenData((user) {
      _nameController.text = user.name;
      _lastNameController.text = user.lastName;
      _emailController.text = user.email;
      _mobileController.text = user.mobile;
      _nationalCodeController.text = user.nationalCode;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _nationalCodeController.dispose();
    super.dispose();
  }

  Future<void> _saveChanges() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await ref
          .read(userNotifierProvider.notifier)
          .updateUserProfile(
            name: _nameController.text.trim(),
            lastName: _lastNameController.text.trim(),
            email: _emailController.text.trim(),
            mobile: _mobileController.text.trim(),
            nationalCode: _nationalCodeController.text.trim(),
          );

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Profile updated successfully'), backgroundColor: Colors.green));
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to update profile: $e'), backgroundColor: Colors.red));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        actions: [
          // Save button in app bar
          TextButton(
            onPressed: _isLoading ? null : _saveChanges,
            child: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const Text('SAVE', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // First Name
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'First Name',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your first name';
                }
                if (value.trim().length < 2) {
                  return 'Name must be at least 2 characters';
                }
                return null;
              },
              enabled: !_isLoading,
            ),

            const SizedBox(height: 16),

            // Last Name
            TextFormField(
              controller: _lastNameController,
              decoration: const InputDecoration(
                labelText: 'Last Name',
                prefixIcon: Icon(Icons.person_outline),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your last name';
                }
                if (value.trim().length < 2) {
                  return 'Last name must be at least 2 characters';
                }
                return null;
              },
              enabled: !_isLoading,
            ),

            const SizedBox(height: 16),

            // Email
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your email';
                }
                final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                if (!emailRegex.hasMatch(value)) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
              enabled: !_isLoading,
            ),

            const SizedBox(height: 16),

            // Mobile
            TextFormField(
              controller: _mobileController,
              decoration: const InputDecoration(
                labelText: 'Mobile',
                prefixIcon: Icon(Icons.phone),
                border: OutlineInputBorder(),
                hintText: '+989121234567',
              ),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your mobile number';
                }
                if (!RegExp(r'^\+?[\d\s-]+$').hasMatch(value)) {
                  return 'Please enter a valid mobile number';
                }
                return null;
              },
              enabled: !_isLoading,
            ),

            const SizedBox(height: 16),

            // National Code
            TextFormField(
              controller: _nationalCodeController,
              decoration: const InputDecoration(
                labelText: 'National Code',
                prefixIcon: Icon(Icons.badge),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your national code';
                }
                if (value.length != 10 || !RegExp(r'^\d+$').hasMatch(value)) {
                  return 'National code must be 10 digits';
                }
                return null;
              },
              enabled: !_isLoading,
            ),

            const SizedBox(height: 32),

            // Save Button (larger button at bottom)
            ElevatedButton(
              onPressed: _isLoading ? null : _saveChanges,
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
              child: _isLoading
                  ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                  : const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
