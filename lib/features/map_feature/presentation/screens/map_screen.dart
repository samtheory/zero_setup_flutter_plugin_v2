import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';
import '../providers/map_notifier.dart';
import '../widgets/poi_marker_widget.dart';
import '../widgets/poi_info_card.dart';
import '../widgets/category_filter_chips.dart';

/// Map Screen
///
/// Main screen displaying the interactive map with user location and POIs.
///
/// **Features:**
/// - Shows user's current location
/// - Displays POI markers on the map
/// - Category filtering for POIs
/// - POI selection with info card
/// - Map controls (zoom, center on user)
///
/// **Usage:**
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(builder: (context) => const MapScreen()),
/// );
/// ```
class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  late final MapController _mapController;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();

    // Initialize map data after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(mapNotifierProvider.notifier).initialize();
    });
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mapState = ref.watch(mapNotifierProvider);

    // Listen for map center changes
    ref.listen(mapNotifierProvider.select((s) => s.mapCenter), (prev, next) {
      if (next != null && prev != next) {
        _mapController.move(next, mapState.zoomLevel);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
        actions: [
          // Refresh button
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.read(mapNotifierProvider.notifier).initialize(),
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: Stack(
        children: [
          // Map
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: mapState.mapCenter ?? const LatLng(35.6892, 51.3890), // Tehran default
              initialZoom: mapState.zoomLevel,
              onPositionChanged: (position, hasGesture) {
                if (hasGesture) {
                  ref.read(mapNotifierProvider.notifier).updateZoom(position.zoom);
                }
              },
              onTap: (_, __) {
                ref.read(mapNotifierProvider.notifier).clearSelectedPoi();
              },
            ),
            children: [
              // Base tile layer (OpenStreetMap)
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app_test_plugin',
              ),

              // POI Markers Layer
              MarkerLayer(
                markers: mapState.filteredPois.map((poi) {
                  return Marker(
                    point: poi.latLng,
                    width: 50,
                    height: 50,
                    child: PoiMarker(
                      poi: poi,
                      isSelected: mapState.selectedPoi?.id == poi.id,
                      onTap: () {
                        ref.read(mapNotifierProvider.notifier).selectPoi(poi);
                      },
                    ),
                  );
                }).toList(),
              ),

              // User Location Marker Layer
              if (mapState.userLocation != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: mapState.userLocation!.latLng,
                      width: 60,
                      height: 60,
                      child: UserLocationMarker(accuracy: mapState.userLocation!.accuracy),
                    ),
                  ],
                ),
            ],
          ),

          // Category Filter Chips (top)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white.withOpacity(0.9),
              child: CategoryFilterChips(
                activeFilters: mapState.activeFilters,
                onToggle: (category) {
                  ref.read(mapNotifierProvider.notifier).toggleCategoryFilter(category);
                },
                onClearAll: () {
                  ref.read(mapNotifierProvider.notifier).clearFilters();
                },
              ),
            ),
          ),

          // Loading indicator
          if (mapState.isLoadingLocation || mapState.isLoadingPois)
            Positioned(
              top: 60,
              left: 0,
              right: 0,
              child: const Center(
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)),
                        SizedBox(width: 12),
                        Text('Loading...'),
                      ],
                    ),
                  ),
                ),
              ),
            ),

          // Error message
          if (mapState.locationError != null)
            Positioned(
              top: 60,
              left: 16,
              right: 16,
              child: Card(
                color: Colors.red[50],
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline, color: Colors.red),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(mapState.locationError!, style: const TextStyle(color: Colors.red)),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          // Clear error by retrying
                          ref.read(mapNotifierProvider.notifier).getCurrentLocation();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),

          // POI Info Card (bottom)
          if (mapState.selectedPoi != null)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: PoiInfoCard(
                poi: mapState.selectedPoi!,
                onClose: () {
                  ref.read(mapNotifierProvider.notifier).clearSelectedPoi();
                },
                onNavigate: () {
                  // Navigate functionality - open in external maps app
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('Navigate to ${mapState.selectedPoi!.name}')));
                },
              ),
            ),

          // Map controls
          Positioned(
            right: 16,
            bottom: mapState.selectedPoi != null ? 220 : 24,
            child: Column(
              children: [
                // Center on user button
                FloatingActionButton.small(
                  heroTag: 'center_on_user',
                  onPressed: mapState.hasLocation ? () => ref.read(mapNotifierProvider.notifier).centerOnUser() : null,
                  backgroundColor: mapState.hasLocation ? null : Colors.grey,
                  child: const Icon(Icons.my_location),
                ),
                const SizedBox(height: 8),
                // Zoom in
                FloatingActionButton.small(
                  heroTag: 'zoom_in',
                  onPressed: () {
                    final newZoom = (mapState.zoomLevel + 1).clamp(1.0, 18.0);
                    ref.read(mapNotifierProvider.notifier).updateZoom(newZoom);
                    _mapController.move(_mapController.camera.center, newZoom);
                  },
                  child: const Icon(Icons.add),
                ),
                const SizedBox(height: 8),
                // Zoom out
                FloatingActionButton.small(
                  heroTag: 'zoom_out',
                  onPressed: () {
                    final newZoom = (mapState.zoomLevel - 1).clamp(1.0, 18.0);
                    ref.read(mapNotifierProvider.notifier).updateZoom(newZoom);
                    _mapController.move(_mapController.camera.center, newZoom);
                  },
                  child: const Icon(Icons.remove),
                ),
              ],
            ),
          ),

          // POI count badge
          Positioned(
            left: 16,
            bottom: 24,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.place, size: 18),
                    const SizedBox(width: 4),
                    Text('${mapState.filteredPois.length} POIs', style: const TextStyle(fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
