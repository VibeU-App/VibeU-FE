import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vibeu_fe/features/newsfeed/presentation/views/newsfeed_view.dart';

class TestHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port) => true;
  }
}

// 1x1 transparent png
final _transparentImage = <int>[
  0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x0D,
  0x49, 0x48, 0x44, 0x52, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01,
  0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4, 0x89, 0x00, 0x00, 0x00,
  0x0A, 0x49, 0x44, 0x41, 0x54, 0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00,
  0x05, 0x00, 0x01, 0x0D, 0x0A, 0x2D, 0xB4, 0x00, 0x00, 0x00, 0x00, 0x49,
  0x45, 0x4E, 0x44, 0xAE, 0x42, 0x60, 0x82,
];

class MockHttpClient extends Fake implements HttpClient {
  @override
  bool autoUncompress = true;

  @override
  Future<HttpClientRequest> getUrl(Uri url) async {
    return MockHttpClientRequest();
  }
}

class MockHttpClientRequest extends Fake implements HttpClientRequest {
  @override
  final HttpHeaders headers = MockHttpHeaders();

  @override
  Future<HttpClientResponse> close() async {
    return MockHttpClientResponse();
  }
}

class MockHttpHeaders extends Fake implements HttpHeaders {
  @override
  void set(String name, Object value, {bool preserveHeaderCase = false}) {}
}

class MockHttpClientResponse extends Fake implements HttpClientResponse {
  @override
  int get statusCode => 200;

  @override
  int get contentLength => _transparentImage.length;

  @override
  HttpClientResponseCompressionState get compressionState =>
      HttpClientResponseCompressionState.notCompressed;

  @override
  StreamSubscription<List<int>> listen(
    void Function(List<int> event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return Stream<List<int>>.fromIterable([_transparentImage]).listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }
}

class MockHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) => MockHttpClient();
}

void main() {
  setUpAll(() {
    HttpOverrides.global = MockHttpOverrides();
  });
  Widget createTestWidget() {
    return const ProviderScope(
      child: MaterialApp(
        home: NewsfeedView(showBottomNavBar: false),
      ),
    );
  }

  testWidgets('Newsfeed renders Helen Chen and Marcus Vance', (tester) async {
    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    expect(find.text('Helen Chen'), findsOneWidget);
    expect(find.text('Marcus Vance'), findsOneWidget);
  });

  testWidgets('Hide Marcus Vance and Undo restores the post', (tester) async {
    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    // Find the more options button for Marcus Vance (the second more_horiz icon)
    final moreButtons = find.byIcon(Icons.more_horiz);
    expect(moreButtons, findsNWidgets(2));

    await tester.tap(moreButtons.at(1));
    await tester.pumpAndSettle();

    // Tap "Hide post"
    final hideOption = find.text('Hide post');
    expect(hideOption, findsOneWidget);
    await tester.tap(hideOption);
    await tester.pumpAndSettle();

    // Marcus Vance is now hidden
    expect(find.text('Marcus Vance'), findsNothing);
    expect(find.text('Helen Chen'), findsOneWidget);

    // SnackBar with "Undo" is displayed
    final undoButton = find.text('Undo');
    expect(undoButton, findsOneWidget);

    // Tap Undo
    await tester.tap(undoButton);
    await tester.pumpAndSettle();

    // Marcus Vance is restored!
    expect(find.text('Marcus Vance'), findsOneWidget);
  });

  testWidgets('Unfollow Helen Chen switches option to Follow Helen Chen', (tester) async {
    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    // Find more options button for Helen Chen (first one)
    final moreButtons = find.byIcon(Icons.more_horiz);
    await tester.tap(moreButtons.first);
    await tester.pumpAndSettle();

    // Initially says "Unfollow Helen Chen"
    expect(find.text('Unfollow Helen Chen'), findsOneWidget);
    expect(find.text('Follow Helen Chen'), findsNothing);

    // Tap "Unfollow Helen Chen"
    await tester.tap(find.text('Unfollow Helen Chen'));
    await tester.pumpAndSettle();

    // Re-open options sheet for Helen Chen
    await tester.tap(moreButtons.first);
    await tester.pumpAndSettle();

    // Now it should show "Follow Helen Chen"!
    expect(find.text('Follow Helen Chen'), findsOneWidget);
    expect(find.text('Unfollow Helen Chen'), findsNothing);

    // Tap "Follow Helen Chen" to follow back
    await tester.tap(find.text('Follow Helen Chen'));
    await tester.pumpAndSettle();

    // Re-open options sheet again
    await tester.tap(moreButtons.first);
    await tester.pumpAndSettle();

    // Now it shows "Unfollow Helen Chen" again
    expect(find.text('Unfollow Helen Chen'), findsOneWidget);
  });
}
