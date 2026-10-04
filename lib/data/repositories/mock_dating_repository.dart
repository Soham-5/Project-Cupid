import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/profile_model.dart';
import '../models/plan_model.dart';

class MockDatingRepository {
  Profile getSaraProfile() {
    return const Profile(
      id: 'sara_20',
      name: 'SARA',
      age: 20,
      tags: ['book lover', 'coffee person', 'night owl', 'music > people'],
      heroPhoto: 'assets/images/sara_hero.jpg',
      secondaryPhoto: 'assets/images/sunset_palms.jpg',
      vinylPhoto: 'assets/images/vinyl_record.jpg',
      vibeBadge: 'her\nvibe',
      friendCount: 3,
      friendAvatars: [
        'assets/images/friend_1.jpg',
        'assets/images/friend_2.jpg',
      ],
      planIdea: PlanIdea(
        id: 'plan_spiderman',
        title: 'SPIDER-MAN\nTONIGHT?',
        subtitle: 'Plan idea',
        actionText: "let's go!",
      ),
    );
  }

  Profile getArjunProfile() {
    return const Profile(
      id: 'arjun_21',
      name: 'ARJUN',
      age: 21,
      tags: ['photographer', 'music nerd', 'overthinker', 'dog person'],
      heroPhoto: 'assets/images/arjun_camera.jpg',
      vinylPhoto: 'assets/images/vinyl_record.jpg',
      vibeBadge: 'his\nvibe',
      friendCount: 4,
      friendAvatars: [
        'assets/images/friend_1.jpg',
        'assets/images/friend_2.jpg',
      ],
      planIdea: PlanIdea(
        id: 'plan_spiderman',
        title: 'SPIDER-MAN\nTONIGHT?',
        subtitle: 'Plan idea',
        actionText: "let's go!",
      ),
    );
  }

  List<Plan> getPlans() {
    return const [
      Plan(
        id: 'plan_spiderman',
        title: 'SPIDER-MAN\nTONIGHT',
        photoPath: 'assets/images/city_night.jpg',
        attendeesCount: 2,
        attendeeAvatars: [
          'assets/images/friend_1.jpg',
          'assets/images/friend_2.jpg',
        ],
        style: PlanCardStyle.darkSpiderman,
        doodle: PlanDoodle.starburst,
      ),
      Plan(
        id: 'plan_cafe',
        title: 'CAFE\nHANGOUT',
        photoPath: 'assets/images/cafe_interior.jpg',
        attendeesCount: 3,
        attendeeAvatars: [
          'assets/images/friend_1.jpg',
          'assets/images/friend_2.jpg',
        ],
        style: PlanCardStyle.creamCafe,
      ),
      Plan(
        id: 'plan_drive',
        title: 'LATE NIGHT\nDRIVE',
        photoPath: 'assets/images/night_drive.jpg',
        attendeesCount: 1,
        attendeeAvatars: [
          'assets/images/friend_1.jpg',
        ],
        style: PlanCardStyle.darkOutlinedDrive,
        doodle: PlanDoodle.moon,
      ),
      Plan(
        id: 'plan_art',
        title: 'ART EXHIBIT\nTHIS WEEKEND',
        photoPath: 'assets/images/art_gallery.jpg',
        attendeesCount: 4,
        attendeeAvatars: [
          'assets/images/friend_1.jpg',
          'assets/images/friend_2.jpg',
        ],
        style: PlanCardStyle.creamArtExhibit,
        doodle: PlanDoodle.heart,
      ),
    ];
  }
}

final datingRepositoryProvider = Provider<MockDatingRepository>((ref) {
  return MockDatingRepository();
});

final saraProfileProvider = Provider<Profile>((ref) {
  return ref.watch(datingRepositoryProvider).getSaraProfile();
});

final arjunProfileProvider = Provider<Profile>((ref) {
  return ref.watch(datingRepositoryProvider).getArjunProfile();
});

final plansListProvider = Provider<List<Plan>>((ref) {
  return ref.watch(datingRepositoryProvider).getPlans();
});

/// Riverpod state providers for interactive features
final activeBottomNavIndexProvider = StateProvider<int>((ref) => 0);
final selectedPlanProvider = StateProvider<Plan?>((ref) => null);
final matchUnlockedProvider = StateProvider<bool>((ref) => false);
