import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vibeu_fe/features/intro/presentation/views/splash_screen.dart';
import 'package:vibeu_fe/features/intro/presentation/views/onboarding_view.dart';
import 'package:vibeu_fe/features/intro/presentation/widgets/pagination_dots.dart';
import 'package:vibeu_fe/features/intro/presentation/widgets/onboarding_bottom_bar.dart';
import 'package:vibeu_fe/config/UI/design_system.dart';

/// Tạo 1x1 pixel PNG giả để mock Image.asset không bị lỗi
final Uint8List _kTransparentImage = Uint8List.fromList([
  0x89,
  0x40,
  0x4E,
  0x47,
  0x0D,
  0x0A,
  0x1A,
  0x0A,
  0x00,
  0x00,
  0x00,
  0x0D,
  0x49,
  0x48,
  0x44,
  0x52,
  0x00,
  0x00,
  0x00,
  0x01,
  0x00,
  0x00,
  0x00,
  0x01,
  0x08,
  0x06,
  0x00,
  0x00,
  0x00,
  0x1F,
  0x15,
  0xC4,
  0x89,
  0x00,
  0x00,
  0x00,
  0x0A,
  0x49,
  0x44,
  0x41,
  0x54,
  0x78,
  0x9C,
  0x62,
  0x00,
  0x01,
  0x00,
  0x00,
  0x05,
  0x00,
  0x01,
  0x0D,
  0x0A,
  0x2D,
  0xB4,
  0x00,
  0x00,
  0x00,
  0x00,
  0x49,
  0x45,
  0x4E,
  0x44,
  0xAE,
  0x42,
  0x60,
  0x82,
]);

class _FakeAssetBundle extends Fake implements AssetBundle {
  @override
  Future<ByteData> load(String key) async {
    if (key == 'AssetManifest.bin') {
      final WriteBuffer buffer = WriteBuffer();
      const StandardMessageCodec().writeValue(buffer, <Object?, Object?>{});
      return buffer.done();
    }
    if (key.endsWith('.json')) {
      return ByteData.sublistView(Uint8List.fromList('{}'.codeUnits));
    }
    return ByteData.sublistView(_kTransparentImage);
  }

  @override
  Future<String> loadString(String key, {bool cache = true}) async {
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
    if (key == 'AssetManifest.bin') {
      final WriteBuffer buffer = WriteBuffer();
      const StandardMessageCodec().writeValue(buffer, <Object?, Object?>{});
      return parser(buffer.done());
    }
    return parser(ByteData.sublistView(_kTransparentImage));
  }

  @override
  Future<ui.ImmutableBuffer> loadBuffer(String key) async {
    return ui.ImmutableBuffer.fromUint8List(_kTransparentImage);
  }

  @override
  void evict(String key) {}
  @override
  void clear() {}
}

/// Wrap widget có Scaffold bọc ngoài để SnackBar không bị lỗi hiển thị
Widget _wrap(Widget child) {
  return MaterialApp(
    home: Scaffold(
      body: MediaQuery(
        data: const MediaQueryData(size: Size(390, 960), devicePixelRatio: 1.0),
        child: DefaultAssetBundle(bundle: _FakeAssetBundle(), child: child),
      ),
    ),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Intro Feature Tests (Splash & Onboarding Flow)', () {
    Future<void> setViewport(WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 960));
    }

    Future<void> resetViewport(WidgetTester tester) async {
      await tester.binding.setSurfaceSize(null);
    }

    // ─────────────────────────────────────────
    // 1. TEST SPLASH TO ONBOARDING FADE
    // ─────────────────────────────────────────
    testWidgets('1. TEST SPLASH TO ONBOARDING FADE', (
      WidgetTester tester,
    ) async {
      await setViewport(tester);
      try {
        await tester.pumpWidget(_wrap(const SplashScreen()));
        await tester.pump();

        // Kiểm tra xem màn hình SplashScreen có tồn tại ban đầu không
        expect(find.byType(SplashScreen), findsOneWidget);

        // Mô phỏng thời gian chờ của Splash Screen (2.5 giây)
        await tester.pump(const Duration(milliseconds: 2500));

        // Đợi toàn bộ hiệu ứng chuyển cảnh (Fade Transition) kết thúc mượt mà
        await tester.pumpAndSettle();

        // Xác thực ứng dụng đã tự chuyển sang màn hình OnboardingView thành công
        expect(find.byType(OnboardingView), findsOneWidget);
      } finally {
        await resetViewport(tester);
      }
    });

    // ─────────────────────────────────────────
    // 2. TEST SWIPING MECHANISM & ANIMATED DOTS
    // ─────────────────────────────────────────
    testWidgets(
      '2. TEST SWIPING MECHANISM & ANIMATED DOTS (SMOOTH INTERPOLATION)',
      (WidgetTester tester) async {
        await setViewport(tester);
        try {
          await tester.pumpWidget(_wrap(const OnboardingView()));
          await tester.pump();

          // 🔥 FIX LỖI: Tìm widget PaginationDots custom của ông thay vì tìm AnimatedContainer chung chung
          expect(find.byType(PaginationDots), findsOneWidget);

          // Kiểm tra chữ tiêu đề trang đầu tiên (SWIPING) hiển thị đúng
          expect(find.text('SWIPING'), findsOneWidget);

          // Vuốt sang trái (Swipe Left) trên vùng PageView để sang trang số 2
          await tester.drag(find.byType(PageView), const Offset(-400, 0));
          await tester.pumpAndSettle();

          // Verify tiêu đề đã đổi trạng thái mượt mà sang "MATCHING"
          expect(find.text('MATCHING'), findsOneWidget);
        } finally {
          await resetViewport(tester);
        }
      },
    );

    // ─────────────────────────────────────────
    // 3. TEST NAVIGATION BUTTONS (SKIP & GET STARTED)
    // ─────────────────────────────────────────
    testWidgets('3. TEST NAVIGATION BUTTONS - SKIP', (
      WidgetTester tester,
    ) async {
      await setViewport(tester);
      try {
        await tester.pumpWidget(_wrap(const OnboardingView()));
        await tester.pump();

        // Tìm chính xác nút SKIP có trong widget OnboardingBottomBar
        final skipButton = find.text('SKIP');
        expect(skipButton, findsOneWidget);

        await tester.tap(skipButton);
        await tester.pumpAndSettle(); // Đợi SnackBar hoặc hiệu ứng hiển thị

        // Kiểm tra xem hệ thống có bắt được tín hiệu điều hướng không
        expect(find.textContaining('Navigating'), findsOneWidget);
      } finally {
        await resetViewport(tester);
      }
    });

    testWidgets('3. TEST NAVIGATION BUTTONS - GET STARTED', (
      WidgetTester tester,
    ) async {
      await setViewport(tester);
      try {
        await tester.pumpWidget(_wrap(const OnboardingView()));
        await tester.pump();

        // Vuốt liên tục 2 lần để đi đến trang cuối cùng (Connecting)
        await tester.drag(find.byType(PageView), const Offset(-400, 0));
        await tester.pumpAndSettle();

        await tester.drag(find.byType(PageView), const Offset(-400, 0));
        await tester.pumpAndSettle();

        // Nút 'Get Started!' xuất hiện ở trang cuối
        final getStartedButton = find.text('Get Started!');
        expect(getStartedButton, findsOneWidget);

        await tester.tap(getStartedButton);
        await tester.pumpAndSettle();

        // Xác thực logic định tuyến hoạt động
        expect(find.textContaining('Navigating'), findsOneWidget);
      } finally {
        await resetViewport(tester);
      }
    });
  });
}
