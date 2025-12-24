import 'package:flutter/material.dart';
import '../../domain/entities/poi_entity.dart';

/// POI Info Card Widget
///
/// Bottom sheet card showing selected POI details.
class PoiInfoCard extends StatelessWidget {
  final PoiEntity poi;
  final VoidCallback? onClose;
  final VoidCallback? onNavigate;

  const PoiInfoCard({super.key, required this.poi, this.onClose, this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, -2))],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle bar
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2)),
            ),
          ),
          const SizedBox(height: 16),

          // Header with icon and name
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _getCategoryColor(poi.category).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(poi.category.icon, style: const TextStyle(fontSize: 28)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      poi.name,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: _getCategoryColor(poi.category).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        poi.category.displayName,
                        style: TextStyle(
                          color: _getCategoryColor(poi.category),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(onPressed: onClose, icon: const Icon(Icons.close)),
            ],
          ),

          // Description
          if (poi.description != null) ...[
            const SizedBox(height: 16),
            Text(poi.description!, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[700])),
          ],

          // Coordinates
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Text(
                '${poi.latitude.toStringAsFixed(4)}, ${poi.longitude.toStringAsFixed(4)}',
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
            ],
          ),

          // Action buttons
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    // Share functionality
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Share ${poi.name}')));
                  },
                  icon: const Icon(Icons.share),
                  label: const Text('Share'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton.icon(
                  onPressed: onNavigate,
                  icon: const Icon(Icons.directions),
                  label: const Text('Navigate'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getCategoryColor(PoiCategory category) {
    switch (category) {
      case PoiCategory.food:
        return Colors.orange;
      case PoiCategory.shopping:
        return Colors.purple;
      case PoiCategory.transportation:
        return Colors.blue;
      case PoiCategory.health:
        return Colors.red;
      case PoiCategory.education:
        return Colors.teal;
      case PoiCategory.entertainment:
        return Colors.pink;
      case PoiCategory.tourism:
        return Colors.amber;
      case PoiCategory.service:
        return Colors.grey;
      case PoiCategory.parking:
        return Colors.indigo;
      case PoiCategory.general:
      default:
        return Colors.green;
    }
  }
}
