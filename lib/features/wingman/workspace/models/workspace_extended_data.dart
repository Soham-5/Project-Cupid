import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/sticker_badge.dart';
import '../utils/wingman_action_handler.dart';

// ==========================================
// BLIND DATE DATA MODELS
// ==========================================

class BlindDateEvent {
  final String id;
  final String title;
  final String time;
  final String lookingFor;
  final int wingmansInterested;
  final String imagePath;
  final Color badgeColor;
  final StickerType badgeType;

  const BlindDateEvent({
    required this.id,
    required this.title,
    required this.time,
    required this.lookingFor,
    required this.wingmansInterested,
    required this.imagePath,
    required this.badgeColor,
    this.badgeType = StickerType.starburst,
  });

  String get cardId => 'wm-blind-event-${toWingmanSlug(title)}';
  String get interestedId => 'wm-blind-event-${toWingmanSlug(title)}-interested';
}

// ==========================================
// MATCH DATA MODELS
// ==========================================

class MatchCandidateItem {
  final String name;
  final int age;
  final String imagePath;
  final bool isAnonymous;

  const MatchCandidateItem({
    required this.name,
    required this.age,
    required this.imagePath,
    this.isAnonymous = false,
  });
}

class MatchCardData {
  final String id;
  final MatchCandidateItem person1;
  final MatchCandidateItem person2;
  final String dateTitle;
  final String dateTime;
  final Color chatButtonColor;
  final bool isAnonymous;

  const MatchCardData({
    required this.id,
    required this.person1,
    required this.person2,
    required this.dateTitle,
    required this.dateTime,
    required this.chatButtonColor,
    this.isAnonymous = false,
  });

  String get cardId => 'wm-match-card-$id';
  String get chatId => 'wm-match-card-$id-chat';
}

// ==========================================
// PROFILE DATA MODELS
// ==========================================

class WorkspaceOtherFriend {
  final String id;
  final String name;
  final int age;
  final String initial;
  final String subtitle;
  final String photoPath;
  final String status; // 'active' or 'paused'
  final Color statusBadgeColor;
  final Color initialBadgeColor;
  final IconData? doodleIcon;

  const WorkspaceOtherFriend({
    required this.id,
    required this.name,
    required this.age,
    required this.initial,
    required this.subtitle,
    required this.photoPath,
    required this.status,
    required this.statusBadgeColor,
    required this.initialBadgeColor,
    this.doodleIcon,
  });

  String get elementId => 'wm-profile-person-${toWingmanSlug(id)}';
}

class WorkspaceHostProfile {
  final String name;
  final int age;
  final String roleContext;
  final String photoPath;
  final List<String> bioTags;
  final String lookingForText;

  const WorkspaceHostProfile({
    required this.name,
    required this.age,
    required this.roleContext,
    required this.photoPath,
    required this.bioTags,
    required this.lookingForText,
  });
}

// ==========================================
// STATIC MOCK DATA
// ==========================================

class WorkspaceExtendedMockData {
  WorkspaceExtendedMockData._();

  // 1. Blind Date Events (matching Image 1 Left)
  static const List<BlindDateEvent> blindDateEvents = [
    BlindDateEvent(
      id: 'movie-night',
      title: 'MOVIE NIGHT',
      time: 'tonight · 8:30 pm',
      lookingFor: 'looking for 1 person',
      wingmansInterested: 2,
      imagePath: 'assets/images/sunset_palms.jpg',
      badgeColor: AppColors.lavender,
    ),
    BlindDateEvent(
      id: 'cafe-hangout',
      title: 'CAFE HANGOUT',
      time: 'tomorrow · 5:00 pm',
      lookingFor: 'looking for 1 person',
      wingmansInterested: 3,
      imagePath: 'assets/images/cafe_interior.jpg',
      badgeColor: AppColors.pink,
    ),
    BlindDateEvent(
      id: 'art-exhibit',
      title: 'ART EXHIBIT',
      time: 'sat · 4:00 pm',
      lookingFor: 'looking for 1 person',
      wingmansInterested: 1,
      imagePath: 'assets/images/art_gallery.jpg',
      badgeColor: AppColors.lime,
    ),
  ];

  // 2. Match Cards (matching Image 1 Right)
  static const List<MatchCardData> matches = [
    MatchCardData(
      id: 'arjun-sara',
      person1: MatchCandidateItem(
        name: 'ARJUN',
        age: 21,
        imagePath: 'assets/images/arjun_camera.jpg',
      ),
      person2: MatchCandidateItem(
        name: 'SARA',
        age: 20,
        imagePath: 'assets/images/sara_hero.jpg',
      ),
      dateTitle: 'coffee date',
      dateTime: 'sat, 7pm',
      chatButtonColor: AppColors.lavender,
      isAnonymous: false,
    ),
    MatchCardData(
      id: 'mehak-rohan',
      person1: MatchCandidateItem(
        name: 'MEHAK',
        age: 21,
        imagePath: 'assets/images/friend_1.jpg',
      ),
      person2: MatchCandidateItem(
        name: 'ROHAN',
        age: 23,
        imagePath: 'assets/images/arjun_camera.jpg',
      ),
      dateTitle: 'art exhibit',
      dateTime: 'sun, 4pm',
      chatButtonColor: AppColors.lime,
      isAnonymous: false,
    ),
    MatchCardData(
      id: 'blind-date',
      person1: MatchCandidateItem(
        name: '?',
        age: 0,
        imagePath: 'assets/images/arjun_camera.jpg',
        isAnonymous: true,
      ),
      person2: MatchCandidateItem(
        name: '?',
        age: 0,
        imagePath: 'assets/images/sara_hero.jpg',
        isAnonymous: true,
      ),
      dateTitle: 'blind date',
      dateTime: 'this saturday',
      chatButtonColor: Color(0xFFF47B95),
      isAnonymous: true,
    ),
  ];

  // 3. Profile Screen Host & Friends (matching Image 2)
  static const WorkspaceHostProfile arjunProfile = WorkspaceHostProfile(
    name: 'ARJUN',
    age: 21,
    roleContext: 'you\'re his wingman',
    photoPath: 'assets/images/arjun_camera.jpg',
    bioTags: [
      'photography enthusiast',
      'vinyl collector',
      'late night overthinker',
      'dog person',
    ],
    lookingForText: 'someone to share random plans, deep talks & memes',
  );

  static const List<WorkspaceOtherFriend> otherFriends = [
    WorkspaceOtherFriend(
      id: 'mehak',
      name: 'MEHAK',
      age: 21,
      initial: 'M',
      subtitle: 'coffee dates & concert buddy',
      photoPath: 'assets/images/friend_1.jpg',
      status: 'active',
      statusBadgeColor: AppColors.lavender,
      initialBadgeColor: AppColors.lime,
    ),
    WorkspaceOtherFriend(
      id: 'rohan',
      name: 'ROHAN',
      age: 23,
      initial: 'R',
      subtitle: 'foodie, cinephile, chaos',
      photoPath: 'assets/images/arjun_camera.jpg',
      status: 'active',
      statusBadgeColor: AppColors.lime,
      initialBadgeColor: AppColors.pink,
    ),
    WorkspaceOtherFriend(
      id: 'isha',
      name: 'ISHA',
      age: 21,
      initial: 'I',
      subtitle: 'introvert but fun (trust)',
      photoPath: 'assets/images/sara_hero.jpg',
      status: 'paused',
      statusBadgeColor: Color(0xFFF47B95),
      initialBadgeColor: AppColors.stickyYellow,
    ),
  ];
}
