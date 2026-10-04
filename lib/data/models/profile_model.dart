import 'package:flutter/material.dart';

class PlanIdea {
  final String id;
  final String title;
  final String subtitle;
  final String actionText;
  final Color themeColor;

  const PlanIdea({
    required this.id,
    required this.title,
    this.subtitle = "Plan idea",
    this.actionText = "let's go!",
    this.themeColor = const Color(0xFFA98BE8),
  });
}

class Profile {
  final String id;
  final String name;
  final int age;
  final List<String> tags;
  final String heroPhoto;
  final String? secondaryPhoto;
  final String? vinylPhoto;
  final String vibeBadge;
  final PlanIdea planIdea;
  final List<String> friendAvatars;
  final int friendCount;

  const Profile({
    required this.id,
    required this.name,
    required this.age,
    required this.tags,
    required this.heroPhoto,
    this.secondaryPhoto,
    this.vinylPhoto,
    this.vibeBadge = "her\nvibe",
    required this.planIdea,
    required this.friendAvatars,
    this.friendCount = 3,
  });

  String get formattedTags => tags.join(' / ');
}
