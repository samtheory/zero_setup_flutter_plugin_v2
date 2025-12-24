import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';
import '../../domain/entities/poi_entity.dart';
import '../../domain/entities/user_location_entity.dart';
import '../../domain/usecases/get_location_usecase.dart';
import 'map_providers.dart';

// ════════════════════════════════════════════════════════════════════════════
// Map State
// ════════════════════════════════════════════════════════════════════════════

/// Map State holding all map-related data
class MapState {
  final UserLocationEntity? userLocation;
  final List<PoiEntity> pois;
  final PoiEntity? selectedPoi;
  final bool isLoadingLocation;
  final bool isLoadingPois;
  final String? locationError;
  final String? poisError;
  final Set<PoiCategory> activeFilters;
  final double zoomLevel;
  final LatLng? mapCenter;

  const MapState({
    this.userLocation,
    this.pois = const [],
    this.selectedPoi,
    this.isLoadingLocation = false,
    this.isLoadingPois = false,
    this.locationError,
    this.poisError,
    this.activeFilters = const {},
    this.zoomLevel = 14.0,
    this.mapCenter,
  });

  MapState copyWith({
    UserLocationEntity? userLocation,
    List<PoiEntity>? pois,
    PoiEntity? selectedPoi,
    bool? isLoadingLocation,
    bool? isLoadingPois,
    String? locationError,
    String? poisError,
    Set<PoiCategory>? activeFilters,
    double? zoomLevel,
    LatLng? mapCenter,
    bool clearSelectedPoi = false,
    bool clearLocationError = false,
    bool clearPoisError = false,
  }) {
    return MapState(
      userLocation: userLocation ?? this.userLocation,
      pois: pois ?? this.pois,
      selectedPoi: clearSelectedPoi ? null : (selectedPoi ?? this.selectedPoi),
      isLoadingLocation: isLoadingLocation ?? this.isLoadingLocation,
      isLoadingPois: isLoadingPois ?? this.isLoadingPois,
      locationError: clearLocationError ? null : (locationError ?? this.locationError),
      poisError: clearPoisError ? null : (poisError ?? this.poisError),
      activeFilters: activeFilters ?? this.activeFilters,
      zoomLevel: zoomLevel ?? this.zoomLevel,
      mapCenter: mapCenter ?? this.mapCenter,
    );
  }

  /// Get filtered POIs based on active category filters
  List<PoiEntity> get filteredPois {
    if (activeFilters.isEmpty) return pois;
    return pois.where((poi) => activeFilters.contains(poi.category)).toList();
  }

  /// Check if user location is available
  bool get hasLocation => userLocation != null;
}

// ════════════════════════════════════════════════════════════════════════════
// Map Notifier
// ════════════════════════════════════════════════════════════════════════════

/// Map State Notifier
///
/// Manages all map-related state including user location and POIs.
///
/// **Usage:**
/// ```dart
/// // Get current state
/// final state = ref.watch(mapNotifierProvider);
///
/// // Access notifier methods
/// ref.read(mapNotifierProvider.notifier).getCurrentLocation();
/// ref.read(mapNotifierProvider.notifier).selectPoi(poi);
/// ```
class MapNotifier extends Notifier<MapState> {
  @override
  MapState build() {
    // Initial state
    return const MapState();
  }

  /// Get user's current location
  Future<void> getCurrentLocation() async {
    state = state.copyWith(isLoadingLocation: true, clearLocationError: true);

    try {
      final useCase = ref.read(getCurrentLocationUseCaseProvider);
      final location = await useCase();
      state = state.copyWith(
        userLocation: location,
        isLoadingLocation: false,
        mapCenter: location.latLng,
      );
    } on LocationServiceDisabledException catch (e) {
      state = state.copyWith(
        isLoadingLocation: false,
        locationError: e.toString(),
      );
    } on LocationPermissionDeniedException catch (e) {
      state = state.copyWith(
        isLoadingLocation: false,
        locationError: e.toString(),
      );
    } on LocationPermissionDeniedForeverException catch (e) {
      state = state.copyWith(
        isLoadingLocation: false,
        locationError: e.toString(),
      );
    } catch (e) {
      state = state.copyWith(
        isLoadingLocation: false,
        locationError: 'Failed to get location: $e',
      );
    }
  }

  /// Load all POIs
  Future<void> loadPois() async {
    state = state.copyWith(isLoadingPois: true, clearPoisError: true);

    try {
      final useCase = ref.read(getAllPoisUseCaseProvider);
      final pois = await useCase();
      state = state.copyWith(
        pois: pois,
        isLoadingPois: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoadingPois: false,
        poisError: 'Failed to load POIs: $e',
      );
    }
  }

  /// Load POIs near user location
  Future<void> loadNearbyPois({double radiusMeters = 5000}) async {
    if (state.userLocation == null) return;

    state = state.copyWith(isLoadingPois: true, clearPoisError: true);

    try {
      final useCase = ref.read(getPoisInRadiusUseCaseProvider);
      final pois = await useCase(
        center: state.userLocation!.latLng,
        radiusMeters: radiusMeters,
      );
      state = state.copyWith(
        pois: pois,
        isLoadingPois: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoadingPois: false,
        poisError: 'Failed to load nearby POIs: $e',
      );
    }
  }

  /// Select a POI
  void selectPoi(PoiEntity poi) {
    state = state.copyWith(
      selectedPoi: poi,
      mapCenter: poi.latLng,
    );
  }

  /// Clear selected POI
  void clearSelectedPoi() {
    state = state.copyWith(clearSelectedPoi: true);
  }

  /// Toggle category filter
  void toggleCategoryFilter(PoiCategory category) {
    final newFilters = Set<PoiCategory>.from(state.activeFilters);
    if (newFilters.contains(category)) {
      newFilters.remove(category);
    } else {
      newFilters.add(category);
    }
    state = state.copyWith(activeFilters: newFilters);
  }

  /// Clear all filters
  void clearFilters() {
    state = state.copyWith(activeFilters: const {});
  }

  /// Update zoom level
  void updateZoom(double zoom) {
    state = state.copyWith(zoomLevel: zoom);
  }

  /// Update map center
  void updateCenter(LatLng center) {
    state = state.copyWith(mapCenter: center);
  }

  /// Center map on user location
  void centerOnUser() {
    if (state.userLocation != null) {
      state = state.copyWith(mapCenter: state.userLocation!.latLng);
    }
  }

  /// Initialize map (get location + load POIs)
  Future<void> initialize() async {
    await getCurrentLocation();
    await loadPois();
  }
}

/// Map Notifier Provider
final mapNotifierProvider = NotifierProvider<MapNotifier, MapState>(() {
  return MapNotifier();
});
