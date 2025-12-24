import '../entities/user_location_entity.dart';
import '../repositories/map_repository.dart';

/// Get Current Location Use Case
///
/// Retrieves the user's current geographic location.
/// Handles permission checks and error cases.
///
/// **Usage:**
/// ```dart
/// final useCase = GetCurrentLocationUseCase(repository);
/// final location = await useCase();
/// print('Current location: ${location.latitude}, ${location.longitude}');
/// ```
class GetCurrentLocationUseCase {
  final MapRepository _repository;

  GetCurrentLocationUseCase(this._repository);

  Future<UserLocationEntity> call() async {
    // Check if location services are enabled
    final isEnabled = await _repository.isLocationServiceEnabled();
    if (!isEnabled) {
      throw LocationServiceDisabledException();
    }

    // Check permission
    final permission = await _repository.checkLocationPermission();
    if (permission == LocationPermissionStatus.denied) {
      // Request permission
      final newPermission = await _repository.requestLocationPermission();
      if (newPermission != LocationPermissionStatus.granted) {
        throw LocationPermissionDeniedException();
      }
    } else if (permission == LocationPermissionStatus.deniedForever) {
      throw LocationPermissionDeniedForeverException();
    }

    return _repository.getCurrentLocation();
  }
}

/// Get Location Stream Use Case
///
/// Provides a stream of location updates for real-time tracking.
class GetLocationStreamUseCase {
  final MapRepository _repository;

  GetLocationStreamUseCase(this._repository);

  Stream<UserLocationEntity> call() {
    return _repository.getLocationStream();
  }
}

/// Location exceptions
class LocationServiceDisabledException implements Exception {
  @override
  String toString() => 'Location services are disabled. Please enable them in settings.';
}

class LocationPermissionDeniedException implements Exception {
  @override
  String toString() => 'Location permission was denied. Please grant permission to use this feature.';
}

class LocationPermissionDeniedForeverException implements Exception {
  @override
  String toString() => 'Location permission is permanently denied. Please enable it in app settings.';
}
