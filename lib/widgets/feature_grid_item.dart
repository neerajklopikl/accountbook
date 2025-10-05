import 'package:flutter/material.dart';
import '../models/feature_item_model.dart';

class FeatureGridItem extends StatelessWidget {
  final FeatureItemModel item;
  final VoidCallback? onTap; // Added onTap callback

  const FeatureGridItem({super.key, required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: onTap, // Use the onTap callback here
        borderRadius: BorderRadius.circular(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: item.color.withOpacity(0.1),
              child: Icon(item.icon, color: item.color, size: 28),
            ),
            const SizedBox(height: 12),
            Text(
              item.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}