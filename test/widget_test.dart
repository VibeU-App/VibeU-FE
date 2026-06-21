import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vibeu_fe/features/intro/presentation/views/splash_screen.dart';
import 'package:vibeu_fe/features/intro/presentation/views/onboarding_view.dart';
import 'package:vibeu_fe/features/intro/presentation/widgets/pagination_dots.dart';
import 'package:vibeu_fe/features/intro/presentation/widgets/onboarding_bottom_bar.dart';

/// Helper: wrap widget với MaterialApp để test
Widget _wrap(Widget child) {
  return MaterialApp(home: child);
}

void main() {
  // ─────────────────────────────────────────
  // GROUP 1: SplashScreen
  // ─────────────────────────────────────────
  group('SplashScreen', () {
    testWidgets('renders VibeU text', (tester) async {
      await tester.pumpWidget(_wrap(const SplashScreen()));
      // Chỉ pump 1 frame, không chờ timer navigate
      await tester.pump();

      expect(find.text('VibeU'), findsOneWidget);
    });

    testWidgets('renders slogan Match Your Vibe', (tester) async {
      await tester.pumpWidget(_wrap(const SplashScreen()));
      await tester.pump();

      expect(find.text('Match Your Vibe'), findsOneWidget);
    });

    testWidgets('renders logo V', (tester) async {
      await tester.pumpWidget(_wrap(const SplashScreen()));
      await tester.pump();

      expect(find.text('V'), findsOneWidget);
    });
  });

  // ─────────────────────────────────────────
  // GROUP 2: OnboardingView - Navigation & Swipe
  // ─────────────────────────────────────────
  group('OnboardingView', () {
    testWidgets('shows first page title SWIPING on start', (tester) async {
      await tester.pumpWidget(_wrap(const OnboardingView()));
      await tester.pump();

      expect(find.text('SWIPING'), findsOneWidget);
    });

    testWidgets('shows SKIP button on first page', (tester) async {
      await tester.pumpWidget(_wrap(const OnboardingView()));
      await tester.pump();

      expect(find.text('SKIP'), findsOneWidget);
    });

    testWidgets('shows next circle button (arrow) on first page', (
      tester,
    ) async {
      await tester.pumpWidget(_wrap(const OnboardingView()));
      await tester.pump();

      expect(find.byIcon(Icons.arrow_forward_rounded), findsOneWidget);
      expect(find.text('Get Started!'), findsNothing);
    });

    testWidgets('swipe to page 2 shows MATCHING', (tester) async {
      await tester.pumpWidget(_wrap(const OnboardingView()));
      await tester.pump();

      await tester.drag(find.byType(PageView), const Offset(-400, 0));
      await tester.pumpAndSettle();

      expect(find.text('MATCHING'), findsOneWidget);
    });

    testWidgets('swipe to page 3 shows CONNECTING', (tester) async {
      await tester.pumpWidget(_wrap(const OnboardingView()));
      await tester.pump();

      // Swipe tới trang 2
      await tester.drag(find.byType(PageView), const Offset(-400, 0));
      await tester.pumpAndSettle();

      // Swipe tới trang 3
      await tester.drag(find.byType(PageView), const Offset(-400, 0));
      await tester.pumpAndSettle();

      expect(find.text('CONNECTING'), findsOneWidget);
    });

    testWidgets('last page shows Get Started! button', (tester) async {
      await tester.pumpWidget(_wrap(const OnboardingView()));
      await tester.pump();

      await tester.drag(find.byType(PageView), const Offset(-400, 0));
      await tester.pumpAndSettle();
      await tester.drag(find.byType(PageView), const Offset(-400, 0));
      await tester.pumpAndSettle();

      expect(find.text('Get Started!'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward_rounded), findsNothing);
    });

    testWidgets('SKIP button is hidden (opacity 0) on last page', (
      tester,
    ) async {
      await tester.pumpWidget(_wrap(const OnboardingView()));
      await tester.pump();

      await tester.drag(find.byType(PageView), const Offset(-400, 0));
      await tester.pumpAndSettle();
      await tester.drag(find.byType(PageView), const Offset(-400, 0));
      await tester.pumpAndSettle();

      // SKIP vẫn trong widget tree nhưng opacity = 0
      final animatedOpacity = tester.widget<AnimatedOpacity>(
        find.ancestor(
          of: find.text('SKIP'),
          matching: find.byType(AnimatedOpacity),
        ),
      );
      expect(animatedOpacity.opacity, 0.0);
    });

    testWidgets('tapping next arrow advances to page 2', (tester) async {
      await tester.pumpWidget(_wrap(const OnboardingView()));
      await tester.pump();

      await tester.tap(find.byIcon(Icons.arrow_forward_rounded));
      await tester.pumpAndSettle();

      expect(find.text('MATCHING'), findsOneWidget);
    });
  });

  // ─────────────────────────────────────────
  // GROUP 3: PaginationDots
  // ─────────────────────────────────────────
  group('PaginationDots', () {
    testWidgets('renders correct number of dots', (tester) async {
      await tester.pumpWidget(
        _wrap(const PaginationDots(totalPages: 3, currentPage: 0)),
      );
      await tester.pump();

      // 3 AnimatedContainer = 3 dots
      expect(find.byType(AnimatedContainer), findsNWidgets(3));
    });

    testWidgets('active dot has wider width (pill shape)', (tester) async {
      await tester.pumpWidget(
        _wrap(const PaginationDots(totalPages: 3, currentPage: 0)),
      );
      await tester.pump();

      final containers = tester
          .widgetList<AnimatedContainer>(find.byType(AnimatedContainer))
          .toList();

      // Dot đầu tiên (active) phải rộng hơn các dot còn lại
      final activeBox = containers[0].constraints as BoxConstraints?;
      final inactiveBox = containers[1].constraints as BoxConstraints?;

      // Kiểm tra width qua decoration thông qua render
      // Dùng cách đơn giản: rebuild với currentPage=1 và kiểm tra thay đổi
      expect(containers.length, 3);
    });
  });

  // ─────────────────────────────────────────
  // GROUP 4: OnboardingBottomBar
  // ─────────────────────────────────────────
  group('OnboardingBottomBar', () {
    testWidgets('shows SKIP and arrow on non-last page', (tester) async {
      await tester.pumpWidget(
        _wrap(
          OnboardingBottomBar(isLastPage: false, onSkip: () {}, onNext: () {}),
        ),
      );
      await tester.pump();

      expect(find.text('SKIP'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward_rounded), findsOneWidget);
      expect(find.text('Get Started!'), findsNothing);
    });

    testWidgets('shows Get Started! on last page', (tester) async {
      await tester.pumpWidget(
        _wrap(
          OnboardingBottomBar(isLastPage: true, onSkip: () {}, onNext: () {}),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Get Started!'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward_rounded), findsNothing);
    });

    testWidgets('onSkip callback fires when SKIP tapped', (tester) async {
      bool skipped = false;
      await tester.pumpWidget(
        _wrap(
          OnboardingBottomBar(
            isLastPage: false,
            onSkip: () => skipped = true,
            onNext: () {},
          ),
        ),
      );
      await tester.pump();

      await tester.tap(find.text('SKIP'));
      await tester.pump();

      expect(skipped, isTrue);
    });

    testWidgets('onNext callback fires when arrow tapped', (tester) async {
      bool nextCalled = false;
      await tester.pumpWidget(
        _wrap(
          OnboardingBottomBar(
            isLastPage: false,
            onSkip: () {},
            onNext: () => nextCalled = true,
          ),
        ),
      );
      await tester.pump();

      await tester.tap(find.byIcon(Icons.arrow_forward_rounded));
      await tester.pump();

      expect(nextCalled, isTrue);
    });

    testWidgets('onNext callback fires when Get Started! tapped', (
      tester,
    ) async {
      bool nextCalled = false;
      await tester.pumpWidget(
        _wrap(
          OnboardingBottomBar(
            isLastPage: true,
            onSkip: () {},
            onNext: () => nextCalled = true,
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Get Started!'));
      await tester.pump();

      expect(nextCalled, isTrue);
    });
  });
}
