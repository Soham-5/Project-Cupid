import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

/// Data model representing a curated candidate profile displayed on the
/// Wingman Workspace Home screen (e.g. SARA, 20).
class WorkspaceCandidateProfile {
  final String id;
  final String name;
  final int age;
  final String heroPhoto;
  final String secondaryPhoto;
  final String vinylPhoto;
  final String vibeBadgeText;
  final List<String> tags;
  final List<String> curatorAvatars;
  final int curatorCount;

  const WorkspaceCandidateProfile({
    required this.id,
    required this.name,
    required this.age,
    required this.heroPhoto,
    required this.secondaryPhoto,
    required this.vinylPhoto,
    this.vibeBadgeText = 'her vibe',
    required this.tags,
    required this.curatorAvatars,
    this.curatorCount = 3,
  });

  /// Factory creating the exact profile matching the design in the attached reference image (Sara, 20)
  factory WorkspaceCandidateProfile.saraDefault() {
    return const WorkspaceCandidateProfile(
      id: 'sara_20',
      name: 'SARA',
      age: 20,
      heroPhoto: 'assets/images/sara_hero.jpg',
      secondaryPhoto: 'assets/images/sunset_palms.jpg',
      vinylPhoto: 'assets/images/vinyl_record.jpg',
      vibeBadgeText: 'her vibe',
      tags: [
        'book lover',
        'coffee person',
        'night owl',
        'music > people',
      ],
      curatorAvatars: [
        'assets/images/friend_1.jpg',
        'assets/images/friend_2.jpg',
      ],
      curatorCount: 3,
    );
  }
}

/// Friend for whom the user is acting as a Wingman (e.g. ARJUN, MEHAK, ROHAN)
class WorkspaceFriendSummary {
  final String id;
  final String name;
  final int age;
  final String initial;
  final String subtitle;
  final String? highlightedWord;
  final Color badgeColor;
  final double badgeRotationDeg;
  final WorkspaceCandidateProfile candidate;

  const WorkspaceFriendSummary({
    required this.id,
    required this.name,
    required this.age,
    required this.initial,
    required this.subtitle,
    this.highlightedWord,
    required this.badgeColor,
    this.badgeRotationDeg = 0.0,
    required this.candidate,
  });
}

/// Mock repository/sample data store for the Wingman Workspace
class WorkspaceMockData {
  WorkspaceMockData._();

  static final List<WorkspaceFriendSummary> defaultFriends = [
    WorkspaceFriendSummary(
      id: 'arjun',
      name: 'ARJUN',
      age: 21,
      initial: 'A',
      subtitle: 'photography · vinyl · late nights',
      highlightedWord: 'vinyl',
      badgeColor: AppColors.lavender,
      badgeRotationDeg: -2.5,
      candidate: WorkspaceCandidateProfile.saraDefault(),
    ),
    WorkspaceFriendSummary(
      id: 'mehak',
      name: 'MEHAK',
      age: 21,
      initial: 'M',
      subtitle: 'coffee · art · spontaneous',
      highlightedWord: null,
      badgeColor: AppColors.lime,
      badgeRotationDeg: 2.0,
      candidate: WorkspaceCandidateProfile.saraDefault(),
    ),
    WorkspaceFriendSummary(
      id: 'rohan',
      name: 'ROHAN',
      age: 23,
      initial: 'R',
      subtitle: 'football · movies · chill',
      highlightedWord: null,
      badgeColor: AppColors.pink,
      badgeRotationDeg: -1.5,
      candidate: WorkspaceCandidateProfile.saraDefault(),
    ),
  ];

  /// Find friend summary by id or name
  static WorkspaceFriendSummary findFriend(String query) {
    final lower = query.toLowerCase();
    return defaultFriends.firstWhere(
      (f) => f.id.toLowerCase() == lower || f.name.toLowerCase() == lower,
      orElse: () => defaultFriends.first,
    );
  }
}
