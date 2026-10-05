import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dating_app/main.dart';
import 'package:dating_app/data/repositories/mock_dating_repository.dart';

void main() {
  testWidgets('Full DatingApp screens & navigation verification test', (WidgetTester tester) async {
    final container = ProviderContainer();

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const DatingApp(),
      ),
    );
    await tester.pumpAndSettle();

    // 1. Verify Home Screen (Screen 1: "For you, by your people")
    expect(find.textContaining('For you'), findsOneWidget);
    expect(find.text('SARA, 20'), findsOneWidget);
    expect(find.textContaining('SPIDER-MAN'), findsOneWidget);
    expect(find.text("let's go!"), findsOneWidget);

    // 2. Switch to Plans Screen (Screen 2: "plan something cool?")
    container.read(activeBottomNavIndexProvider.notifier).state = 1;
    await tester.tap(find.text('plans'));
    await tester.pumpAndSettle();

    expect(find.text('plan something'), findsOneWidget);
    expect(find.text('cool?'), findsOneWidget);
    expect(find.textContaining('CAFE'), findsOneWidget);
    expect(find.textContaining('surprise me'), findsOneWidget);

    // 3. Switch to Match Screen (Screen 4: "it's a match!")
    container.read(activeBottomNavIndexProvider.notifier).state = 2;
    await tester.tap(find.text('match'));
    await tester.pumpAndSettle();

    expect(find.text("it's a match!"), findsOneWidget);
    expect(find.text('start talking'), findsOneWidget);
    expect(find.text('maybe later'), findsOneWidget);

    // 4. Switch to Vibes Screen
    container.read(activeBottomNavIndexProvider.notifier).state = 3;
    await tester.tap(find.text('vibes'));
    await tester.pumpAndSettle();

    expect(find.text('vibes & moments'), findsOneWidget);
    expect(find.textContaining('STANDS OUT'), findsOneWidget);

    // 5. Switch to Profile Screen (Screen 3: "ARJUN, 21")
    container.read(activeBottomNavIndexProvider.notifier).state = 4;
    await tester.tap(find.text('you'));
    await tester.pumpAndSettle();

    expect(find.text('ARJUN, 21'), findsOneWidget);
    expect(find.text('photographer'), findsOneWidget);
    expect(find.text('music nerd'), findsOneWidget);
  });
}
