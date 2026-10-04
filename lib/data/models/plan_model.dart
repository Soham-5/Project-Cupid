import 'package:flutter/material.dart';

enum PlanCardStyle {
  darkSpiderman,      // Photo left, dark card, starburst
  creamCafe,          // Cream torn card, photo right, tape
  darkOutlinedDrive,  // Dark outlined card, photo left, moon doodle
  creamArtExhibit,    // Cream card, photo right, pink heart doodle
}

enum PlanDoodle {
  spider,
  moon,
  heart,
  starburst,
  none,
}

class Plan {
  final String id;
  final String title;
  final String photoPath;
  final int attendeesCount;
  final List<String> attendeeAvatars;
  final PlanCardStyle style;
  final PlanDoodle doodle;
  final Color? accentColor;

  const Plan({
    required this.id,
    required this.title,
    required this.photoPath,
    required this.attendeesCount,
    required this.attendeeAvatars,
    required this.style,
    this.doodle = PlanDoodle.none,
    this.accentColor,
  });
}
