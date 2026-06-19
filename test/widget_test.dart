import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vibeu_fe/features/intro/presentation/views/splash_screen.dart';
import 'package:vibeu_fe/features/intro/presentation/views/onboarding_view.dart';
import 'package:vibeu_fe/features/intro/presentation/widgets/pagination_dots.dart';
import 'package:vibeu_fe/features/intro/presentation/widgets/onboarding_bottom_bar.dart';

/// Tạo 1x1 pixel PNG giả để mock Image.asset không bị lỗi
final Uint8List _kTransparentImage = Uint8List.fromList([
  0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A,
  0x00, 0x00, 0x00, 0x0D, 0x49, 0x48, 0x44, 0x52,
  0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01,
  0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4,
  0x89, 0x00, 0x00, 0x00, 0x0A, 0x49, 0x44, 0x41,
  0x54, 0x78, 0x9C, 0x62, 0x00, 0x01, 0x00, 0x00,
  0x05, 0x00, 0x01, 0x0D, 0x0A, 0x2D, 0xB4, 0x00,
  0x00, 0x00, 0x00, 0x49, 0x45, 0x4E, 0x44, 0xAE,
  0x42, 0x60, 0x82,
]);

/// Mock AssetBundle trả về ảnh giả cho mọi asset
class _FakeAssetBundle extends Fake implements AssetBundle {
  @override
  Future<ByteData> load(String key) async {
    return ByteData.sublistView(_kTransparentImage);
  }

  @override
  Future<String> loadString(String key, {bool cache = true}) async {
    // Trả về asset manifest rỗng hợp lệ
    return '{}';
  }

  @override
  Future<T> loadStructuredData<T>(
    String key,
    Future<T> Function(String value) parser,
  ) async {
    return parser('{}');
  }

  @override
  Future<T> loadStructuredBinaryData<T>(
    String key,
    FutureOr<T> Function(ByteData data) parser,
  ) async {
    return parser(ByteData.sublistView(_kTransparentImage));
  }

  @override
  void evict(String key) {}

  @override
  void clear() {}
}

/// Wrap widget với MaterialApp + FakeAssetBundle
/// Dùng MediaQuery để set màn hình lớn hơn, tránh overflow
Widget _wrap(Widget child) {
  return MaterialApp(
    home: MediaQuery(
      data: const MediaQueryData(
        size: Size(390, 844), // iPhone 14 size
        devicePixelRatio: 1.0,
      ),
      child: DefaultAssetBundle(
        bundle: _FakeAssetBundle(),
        child: child,
      ),
    ),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // ─────────────────────────────────────────
  // GROUP 1: SplashScreen
  // ─────────────────────────────────────────
  group('SplashScreen', () {
    testWidgets('renders VibeU text', (tester) async {
      await tester.pumpWidget(_wrap(const SplashScreen()));
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

    testWidgets('shows next circle button (arrow) on first page', (tester) async {
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
      await tester.drag(find.byType(PageView), const Offset(-400, 0));
      await tester.pumpAndSettle();
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

    testWidgets('SKIP button is hidden (opacity 0) on last page', (tester) async {
      await tester.pumpWidget(_wrap(const OnboardingView()));
      await tester.pump();
      await tester.drag(find.byType(PageView), const Offset(-400, 0));
      await tester.pumpAndSettle();
      await tester.drag(find.byType(PageView), const Offset(-400, 0));
      await tester.pumpAndSettle();

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
      expect(find.byType(AnimatedContainer), findsNWidgets(3));
    });

    testWidgets('active dot is wider than inactive dots', (tester) async {
      await tester.pumpWidget(
        _wrap(const PaginationDots(totalPages: 3, currentPage: 0)),
      );
      await tester.pump();

      final boxes = tester
          .renderObjectList<RenderBox>(
            find.byType(AnimatedContainer),
          )
          .toList();

      // Active dot (index 0) phải rộng hơn inactive dot (index 1)
      expect(boxes[0].size.width, greaterThan(boxes[1].size.width));
    });
  });

  // ─────────────────────────────────────────
  // GROUP 4: OnboardingBottomBar
  // ─────────────────────────────────────────
  group('OnboardingBottomBar', () {
    testWidgets('shows SKIP and arrow on non-last page', (tester) async {
      await tester.pumpWidget(
        _wrap(OnboardingBottomBar(
          isLastPage: false,
          onSkip: () {},
          onNext: () {},
        )),
      );
      await tester.pump();
      expect(find.text('SKIP'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward_rounded), findsOneWidget);
      expect(find.text('Get Started!'), findsNothing);
    });

    testWidgets('shows Get Started! on last page', (tester) async {
      await tester.pumpWidget(
        _wrap(OnboardingBottomBar(
          isLastPage: true,
          onSkip: () {},
          onNext: () {},
        )),
      );
      await tester.pumpAndSettle();
      expect(find.text('Get Started!'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward_rounded), findsNothing);
    });

    testWidgets('onSkip callback fires when SKIP tapped', (tester) async {
      bool skipped = false;
      await tester.pumpWidget(
        _wrap(OnboardingBottomBar(
          isLastPage: false,
          onSkip: () => skipped = true,
          onNext: () {},
        )),
      );
      await tester.pump();
      await tester.tap(find.text('SKIP'));
      await tester.pump();
      expect(skipped, isTrue);
    });

    testWidgets('onNext callback fires when arrow tapped', (tester) async {
      bool nextCalled = false;
      await tester.pumpWidget(
        _wrap(OnboardingBottomBar(
          isLastPage: false,
          onSkip: () {},
          onNext: () => nextCalled = true,
        )),
      );
      await tester.pump();
      await tester.tap(find.byIcon(Icons.arrow_forward_rounded));
      await tester.pump();
      expect(nextCalled, isTrue);
    });

    testWidgets('onNext callback fires when Get Started! tapped', (tester) async {
      bool nextCalled = false;
      await tester.pumpWidget(
        _wrap(OnboardingBottomBar(
          isLastPage: true,
          onSkip: () {},
          onNext: () => nextCalled = true,
        )),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Get Started!'));
      await tester.pump();
      expect(nextCalled, isTrue);
    });
  });
}
