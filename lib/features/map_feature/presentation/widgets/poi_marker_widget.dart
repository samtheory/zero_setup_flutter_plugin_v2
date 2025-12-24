import 'package:flutter/material.dart';
import '../../domain/entities/poi_entity.dart';

/// POI Marker Widget
///
/// Custom marker for POI locations on the map.
class PoiMarker extends StatelessWidget {
  final PoiEntity poi;
  final bool isSelected;
  final VoidCallback? onTap;

  const PoiMarker({
    super.key,
    required this.poi,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? _getCategoryColor(poi.category) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: isSelected ? 8 : 4,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(
            color: _getCategoryColor(poi.category),
            width: 2,
          ),
        ),
        child: Text(
          poi.category.icon,
          style: TextStyle(fontSize: isSelected ? 24 : 20),
        ),
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

/// User Location Marker Widget
class UserLocationMarker extends StatelessWidget {
  final double? accuracy;

  const UserLocationMarker({super.key, this.accuracy});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Accuracy circle
        if (accuracy != null)
          Container(
            width: accuracy! / 2,
            height: accuracy! / 2,
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
          ),
        // Outer pulse ring
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
        ),
        // Inner dot
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 3),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.4),
                blurRadius: 8,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
