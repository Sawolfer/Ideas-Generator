import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:provider/provider.dart';
import '../ActivityProvider.dart';

import '../model/ActivityModel.dart';

class ActivityCard extends StatelessWidget {
  final Activity activity;
  const ActivityCard({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _getIconForType(activity.type),
                size: 80,
                color: Colors.white.withOpacity(0.9),
              ),
              const SizedBox(height: 20),
              Text(
                activity.activity,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Chip(
                label: Text(activity.type.toUpperCase()),
                backgroundColor: Colors.black.withOpacity(0.3),
                labelStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                side: BorderSide.none,
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIconForType(String type) {
    switch (type.toLowerCase()) {
      // FIX: toLowerCase для надежности
      case 'education':
        return Icons.school;
      case 'recreational':
        return Icons.sports_esports;
      case 'social':
        return Icons.people;
      case 'diy':
        return Icons.build;
      case 'charity':
        return Icons.volunteer_activism;
      case 'cooking':
        return Icons.restaurant;
      case 'relaxation':
        return Icons.spa;
      case 'music':
        return Icons.music_note;
      case 'busywork':
        return Icons.work;
      default:
        return Icons.lightbulb;
    }
  }
}