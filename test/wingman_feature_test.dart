import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dating_app/main.dart';
import 'package:dating_app/features/wingman/wingman_config.dart';

void main() {
  group('Wingman Feature & Flow Tests', () {
    testWidgets('Full Wingman interactive flow test', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: DatingApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Tap Wingman in bottom nav
      expect(find.text('wingman'), findsOneWidget);
      await tester.tap(find.text('wingman'));
      await tester.pumpAndSettle();

      // 1. Verify Wingman Home screen
      expect(find.text('Wingman'), findsOneWidget);
      expect(find.text('your friend, your mission'), findsOneWidget);
      expect(find.text('on call'), findsOneWidget);
      expect(find.text('MY PEOPLE'), findsOneWidget);
      expect(find.text('PICK A MISSION'), findsOneWidget);

      // 2. Test "see all" button -> navigates to My People screen
      await tester.tap(find.text('see all'));
      await tester.pumpAndSettle();

      expect(find.text('My People'), findsOneWidget);
      expect(find.text('Friends who\'ve trusted you to be their wingman.'), findsOneWidget);
      expect(find.text('easy conversation · low-key dates'), findsOneWidget);
      expect(find.text('music · spontaneous plans'), findsOneWidget);
      expect(find.text('same humour · no pretence'), findsOneWidget);

      // 3. Tap Friend Y from My People -> opens scouting for Y
      await tester.tap(find.text('Y').first);
      await tester.pumpAndSettle();

      expect(find.text('Find Their Person'), findsOneWidget);
      expect(find.text('blind-date scout · Y'), findsOneWidget);
      expect(find.text('MAYA'), findsOneWidget);

      // 4. Test "not their vibe?" pass button
      final passBtn = find.text('×');
      await tester.ensureVisible(passBtn);
      await tester.pumpAndSettle();
      await tester.tap(passBtn);
      await tester.pumpAndSettle();

      expect(find.text('RIYA'), findsOneWidget);

      // 5. Test "could work?" button on next candidates until completion
      final likeBtn = find.byIcon(Icons.favorite_rounded);
      await tester.ensureVisible(likeBtn);
      await tester.pumpAndSettle();
      await tester.tap(likeBtn); // Advances from Riya to Tara
      await tester.pumpAndSettle();

      expect(find.text('TARA'), findsOneWidget);

      // Like Tara -> completes scouting, shows "Nice eye."
      await tester.ensureVisible(likeBtn);
      await tester.pumpAndSettle();
      await tester.tap(likeBtn);
      await tester.pumpAndSettle();

      expect(find.text('Nice eye.'), findsOneWidget);
      expect(find.textContaining('You found someone worth putting in front of your friend'), findsOneWidget);
      expect(find.text('one good match is enough.'), findsOneWidget);

      // 6. Test "keep scouting →" button
      await tester.tap(find.text('keep scouting →'));
      await tester.pumpAndSettle();

      expect(find.text('Find Their Person'), findsOneWidget);
      expect(find.text('MAYA'), findsOneWidget);
    });

    test('Rollback documentation and config verification', () {
      // Verifies that WingmanConfig has the toggle field available for 1-step rollback
      expect(WingmanConfig.enabled, isTrue);
    });
  });
}
