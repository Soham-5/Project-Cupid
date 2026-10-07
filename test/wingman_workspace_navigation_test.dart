import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dating_app/main.dart';

void main() {
  group('Wingman Workspace Multi-Screen Flow Tests', () {
    testWidgets('Workspace bottom nav switches between Home, Blind Date, Match, Vibes, Profile and back', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: DatingApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Navigate to Wingman tab in main shell
      await tester.tap(find.text('wingman'));
      await tester.pumpAndSettle();

      // Tap ARJUN to slide in the Wingman workspace
      await tester.tap(find.text('ARJUN'));
      await tester.pumpAndSettle();

      // ==========================================
      // 1. HOME SCREEN (active initially)
      // ==========================================
      expect(find.textContaining('For you'), findsOneWidget);
      expect(find.text('SARA, 20'), findsOneWidget);

      // Verify Home buttons with unique IDs
      expect(find.byKey(const ValueKey('wm-home-dislike-btn')), findsOneWidget);
      expect(find.byKey(const ValueKey('wm-home-like-btn')), findsOneWidget);
      await tester.ensureVisible(find.byKey(const ValueKey('wm-home-like-btn')));
      await tester.tap(find.byKey(const ValueKey('wm-home-like-btn')));
      await tester.pumpAndSettle();

      // ==========================================
      // 2. SWITCH TO BLIND DATE TAB
      // ==========================================
      await tester.tap(find.text('blind date'));
      await tester.pumpAndSettle();

      expect(find.text('blind date'), findsWidgets);
      expect(find.text('set up something real'), findsOneWidget);
      expect(find.text('upcoming events'), findsOneWidget);
      expect(find.text('MOVIE NIGHT'), findsOneWidget);
      expect(find.text('CAFE HANGOUT'), findsOneWidget);
      expect(find.text('ART EXHIBIT'), findsOneWidget);
      expect(find.text('create your own'), findsOneWidget);
      expect(find.text('post a plan'), findsOneWidget);

      // Test unique IDs in Blind Date
      expect(find.byKey(const ValueKey('wm-blind-event-movie-night')), findsOneWidget);
      expect(find.byKey(const ValueKey('wm-blind-event-movie-night-interested')), findsOneWidget);
      expect(find.byKey(const ValueKey('wm-blind-event-cafe-hangout')), findsOneWidget);
      expect(find.byKey(const ValueKey('wm-blind-event-cafe-hangout-interested')), findsOneWidget);
      expect(find.byKey(const ValueKey('wm-blind-event-art-exhibit')), findsOneWidget);
      expect(find.byKey(const ValueKey('wm-blind-event-art-exhibit-interested')), findsOneWidget);
      expect(find.byKey(const ValueKey('wm-blind-post-plan-btn')), findsOneWidget);

      await tester.tap(find.byKey(const ValueKey('wm-blind-event-movie-night')));
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.byKey(const ValueKey('wm-blind-post-plan-btn')));
      await tester.tap(find.byKey(const ValueKey('wm-blind-post-plan-btn')));
      await tester.pumpAndSettle();

      // ==========================================
      // 3. SWITCH TO MATCH TAB
      // ==========================================
      await tester.tap(find.text('match'));
      await tester.pumpAndSettle();

      expect(find.text("it's a match!"), findsOneWidget);
      expect(find.text('wingmen made it happen'), findsOneWidget);
      expect(find.text('all matches'), findsOneWidget);
      expect(find.text('upcoming'), findsOneWidget);
      expect(find.text('past'), findsOneWidget);

      // Test filter pills switching active state visually
      expect(find.byKey(const ValueKey('wm-match-filter-all')), findsOneWidget);
      expect(find.byKey(const ValueKey('wm-match-filter-upcoming')), findsOneWidget);
      expect(find.byKey(const ValueKey('wm-match-filter-past')), findsOneWidget);

      await tester.tap(find.byKey(const ValueKey('wm-match-filter-upcoming')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('wm-match-filter-all')));
      await tester.pumpAndSettle();

      // Test match cards and chat buttons with unique IDs
      expect(find.byKey(const ValueKey('wm-match-card-arjun-sara')), findsOneWidget);
      expect(find.byKey(const ValueKey('wm-match-card-arjun-sara-chat')), findsOneWidget);
      expect(find.byKey(const ValueKey('wm-match-card-mehak-rohan')), findsOneWidget);
      expect(find.byKey(const ValueKey('wm-match-card-mehak-rohan-chat')), findsOneWidget);
      expect(find.byKey(const ValueKey('wm-match-card-blind-date')), findsOneWidget);
      expect(find.byKey(const ValueKey('wm-match-card-blind-date-chat')), findsOneWidget);

      await tester.tap(find.byKey(const ValueKey('wm-match-card-arjun-sara-chat')));
      await tester.pumpAndSettle();

      // ==========================================
      // 4. SWITCH TO VIBES TAB (PLACEHOLDER)
      // ==========================================
      await tester.tap(find.text('vibes'));
      await tester.pumpAndSettle();

      expect(find.text('vibes'), findsWidgets);
      expect(find.text('vibes coming soon'), findsOneWidget);

      // ==========================================
      // 5. SWITCH TO PROFILE TAB
      // ==========================================
      await tester.tap(find.text('profile'));
      await tester.pumpAndSettle();

      expect(find.text("ARJUN'S PROFILE"), findsOneWidget);
      expect(find.text("you're his "), findsOneWidget);
      expect(find.text("wingman"), findsWidgets);
      expect(find.text("other people you're wingman for"), findsOneWidget);
      expect(find.text('add someone'), findsOneWidget);
      expect(find.text('add new person'), findsOneWidget);

      // Verify unique IDs on Profile screen
      expect(find.byKey(const ValueKey('wm-profile-back-arrow')), findsOneWidget);
      expect(find.byKey(const ValueKey('wm-profile-top-card')), findsOneWidget);
      expect(find.byKey(const ValueKey('wm-profile-add-someone-btn')), findsOneWidget);
      expect(find.byKey(const ValueKey('wm-profile-person-mehak')), findsOneWidget);
      expect(find.byKey(const ValueKey('wm-profile-person-rohan')), findsOneWidget);
      expect(find.byKey(const ValueKey('wm-profile-person-isha')), findsOneWidget);
      expect(find.byKey(const ValueKey('wm-profile-add-new-person')), findsOneWidget);

      await tester.tap(find.byKey(const ValueKey('wm-profile-add-someone-btn')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('wm-profile-person-mehak')));
      await tester.pumpAndSettle();

      // ==========================================
      // 6. EXIT TO MAIN USER PROFILE ("YOU" TAB)
      // ==========================================
      // Tapping top card exits workspace and returns to main profile
      await tester.tap(find.byKey(const ValueKey('wm-profile-top-card')));
      await tester.pumpAndSettle();

      // Verify we are now on the app's main user profile page ("ARJUN, 21" - profile_screen.dart)
      expect(find.text('photographer'), findsOneWidget);
      expect(find.text('music nerd'), findsOneWidget);
    });
  });
}
