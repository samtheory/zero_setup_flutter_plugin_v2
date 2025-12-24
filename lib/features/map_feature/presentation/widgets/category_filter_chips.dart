import 'package:flutter/material.dart';
import '../../domain/entities/poi_entity.dart';

/// Category Filter Chips Widget
///
/// Horizontal list of filter chips for POI categories.
class CategoryFilterChips extends StatelessWidget {
  final Set<PoiCategory> activeFilters;
  final Function(PoiCategory) onToggle;
  final VoidCallback? onClearAll;

  const CategoryFilterChips({
    super.key,
    required this.activeFilters,
    required this.onToggle,
    this.onClearAll,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          // Clear all button
          if (activeFilters.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ActionChip(
                label: const Text('Clear'),
                avatar: const Icon(Icons.clear, size: 18),
                onPressed: onClearAll,
              ),
            ),
          // Category chips
          ...PoiCategory.values.map((category) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilterChip(
                  label: Text('${category.icon} ${category.displayName}'),
                  selected: activeFilters.contains(category),
                  onSelected: (_) => onToggle(category),
                  selectedColor: _getCategoryColor(category).withOpacity(0.2),
                  checkmarkColor: _getCategoryColor(category),
                ),
              )),
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
