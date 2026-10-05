import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class WingmanFriend {
  final String id;
  final String name;
  final String initial;
  final String subtitle;
  final String preference;
  final Color badgeColor;
  final double badgeRotationDeg;
  final String forYourFriendContext;

  const WingmanFriend({
    required this.id,
    required this.name,
    required this.initial,
    required this.subtitle,
    required this.preference,
    required this.badgeColor,
    required this.badgeRotationDeg,
    required this.forYourFriendContext,
  });
}

class WingmanCandidate {
  final String name;
  final int age;
  final List<String> traits;
  final Color backgroundColor;
  final String contextNote;
  final String? photoAsset;

  const WingmanCandidate({
    required this.name,
    required this.age,
    required this.traits,
    required this.backgroundColor,
    required this.contextNote,
    this.photoAsset,
  });
}

/// Static mock data matching the prototype exactly
class WingmanMockData {
  WingmanMockData._();

  static const List<WingmanFriend> friends = [
    WingmanFriend(
      id: 'x',
      name: 'X',
      initial: 'X',
      subtitle: 'your friend · blind-date setup',
      preference: 'easy conversation · low-key dates',
      badgeColor: AppColors.lavender,
      badgeRotationDeg: -3.0,
      forYourFriendContext:
          'X likes low-key plans, good conversation and people who don\'t take themselves too seriously.',
    ),
    WingmanFriend(
      id: 'y',
      name: 'Y',
      initial: 'Y',
      subtitle: 'your friend · blind-date setup',
      preference: 'music · spontaneous plans',
      badgeColor: AppColors.lime,
      badgeRotationDeg: 2.0,
      forYourFriendContext:
          'Y is into spontaneous plans, music, and people who don\'t make things awkward.',
    ),
    WingmanFriend(
      id: 'z',
      name: 'Z',
      initial: 'Z',
      subtitle: 'your friend · blind-date setup',
      preference: 'same humour · no pretence',
      badgeColor: AppColors.pink,
      badgeRotationDeg: -2.0,
      forYourFriendContext:
          'Z wants someone with the same humour, good energy, and absolutely no pretence.',
    ),
  ];

  static const List<WingmanCandidate> candidates = [
    WingmanCandidate(
      name: 'MAYA',
      age: 21,
      traits: ['film nights', 'coffee', 'dry humour'],
      backgroundColor: AppColors.lavender,
      contextNote:
          'X likes low-key plans, good conversation and people who don\'t take themselves too seriously.',
      photoAsset: 'assets/images/sara_hero.jpg',
    ),
    WingmanCandidate(
      name: 'RIYA',
      age: 22,
      traits: ['indie gigs', 'books', 'chaotic good'],
      backgroundColor: AppColors.lime,
      contextNote:
          'Y is into spontaneous plans, music, and people who don\'t make things awkward.',
      photoAsset: 'assets/images/friend_1.jpg',
    ),
    WingmanCandidate(
      name: 'TARA',
      age: 21,
      traits: ['late walks', 'art', 'bad puns'],
      backgroundColor: AppColors.pink,
      contextNote:
          'Z wants someone with the same humour, good energy, and absolutely no pretence.',
      photoAsset: 'assets/images/friend_2.jpg',
    ),
  ];
}
