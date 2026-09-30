import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vibeu_fe/features/newsfeed/presentation/controllers/newsfeed_controller.dart';

void main() {
  group('NewsfeedController Tests', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('Initial posts contain Helen Chen and Marcus Vance', () {
      final posts = container.read(newsfeedControllerProvider);
      expect(posts.length, 2);
      expect(posts[0].authorName, 'Helen Chen');
      expect(posts[1].authorName, 'Marcus Vance');
    });

    test('Hide Marcus Vance, then Undo properly restores Marcus at original index', () {
      final notifier = container.read(newsfeedControllerProvider.notifier);
      final initialPosts = container.read(newsfeedControllerProvider);
      final marcus = initialPosts[1];
      final marcusIndex = 1;

      // Hide Marcus
      notifier.deletePost(marcus.id);
      var posts = container.read(newsfeedControllerProvider);
      expect(posts.length, 1);
      expect(posts.any((p) => p.id == marcus.id), isFalse);

      // Undo / restore Marcus
      notifier.restorePost(marcus, index: marcusIndex);
      posts = container.read(newsfeedControllerProvider);
      expect(posts.length, 2);
      expect(posts[1].id, marcus.id);
      expect(posts[1].authorName, 'Marcus Vance');
    });

    test('Hide Marcus first, then hide Helen, then Undo restores posts', () {
      final notifier = container.read(newsfeedControllerProvider.notifier);
      final initialPosts = container.read(newsfeedControllerProvider);
      final helen = initialPosts[0];
      final marcus = initialPosts[1];

      // Hide Marcus (index 1)
      notifier.deletePost(marcus.id);
      expect(container.read(newsfeedControllerProvider).length, 1);

      // Hide Helen (index 0)
      notifier.deletePost(helen.id);
      expect(container.read(newsfeedControllerProvider).length, 0);

      // Restore Helen
      notifier.restorePost(helen, index: 0);
      expect(container.read(newsfeedControllerProvider).length, 1);
      expect(container.read(newsfeedControllerProvider)[0].id, helen.id);

      // Restore Marcus
      notifier.restorePost(marcus, index: 1);
      expect(container.read(newsfeedControllerProvider).length, 2);
      expect(container.read(newsfeedControllerProvider)[0].id, helen.id);
      expect(container.read(newsfeedControllerProvider)[1].id, marcus.id);
    });

    test('FollowRelationsNotifier toggles follow and unfollow properly', () {
      final notifier = container.read(followRelationsProvider.notifier);

      // Initial state: Helen and Marcus are followed
      expect(notifier.isFollowing('Helen Chen'), isTrue);
      expect(notifier.isFollowing('Marcus Vance'), isTrue);

      // Unfollow Helen Chen
      notifier.unfollow('Helen Chen');
      expect(notifier.isFollowing('Helen Chen'), isFalse);
      expect(container.read(followRelationsProvider).contains('Helen Chen'), isFalse);

      // Follow Helen Chen back
      notifier.follow('Helen Chen');
      expect(notifier.isFollowing('Helen Chen'), isTrue);
      expect(container.read(followRelationsProvider).contains('Helen Chen'), isTrue);

      // Toggle follow
      notifier.toggleFollow('Helen Chen');
      expect(notifier.isFollowing('Helen Chen'), isFalse);
    });
  });
}
