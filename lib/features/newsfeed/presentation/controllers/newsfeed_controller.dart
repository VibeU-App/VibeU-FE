import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vibeu_fe/features/Me/presentation/controllers/me_state.dart';

List<UserPost> createInitialNewsfeedPosts() {
  final now = DateTime.now();
  return [
    UserPost(
      id: 'news_1',
      authorName: 'Helen Chen',
      authorAvatar: 'https://api.dicebear.com/9.x/avataaars/png?seed=HelenChen',
      createdAt: now.subtract(const Duration(minutes: 3)),
      contentText:
          'Just arrived in Tokyo! The cherry blossoms are absolutely breathtaking this season. Anyone have cafe recommendations around Shibuya? 🌸✨',
      likeCount: 24,
      commentCount: 8,
      isLiked: false,
      comments: [
        PostComment(
          id: 'c_helen_1',
          authorName: 'Kenji',
          timestamp: '3m ago',
          content: 'Check out Fuglen Tokyo near Yoyogi Park! Amazing vibes.',
        ),
      ],
    ),
    UserPost(
      id: 'news_2',
      authorName: 'Marcus Vance',
      authorAvatar: 'https://api.dicebear.com/9.x/avataaars/png?seed=MarcusVance',
      createdAt: now.subtract(const Duration(hours: 1)),
      contentText:
          'Weekend baking project was a success. Sourdough bread came out perfectly golden! 🍞',
      imagePath:
          'https://images.unsplash.com/photo-1589367920969-ab8e050bbb04?w=800',
      likeCount: 142,
      commentCount: 18,
      isLiked: false,
      comments: [
        PostComment(
          id: 'c_marcus_1',
          authorName: 'Sarah',
          timestamp: '45m ago',
          content: 'That crust looks incredible! Recipe please? 😋',
        ),
      ],
    ),
  ];
}

class NewsfeedController extends Notifier<List<UserPost>> {
  @override
  List<UserPost> build() {
    return createInitialNewsfeedPosts();
  }

  void addPost(UserPost post) {
    // New posts appear at the top of the feed
    state = [post, ...state];
  }

  void restorePost(UserPost post, {int? index}) {
    // Avoid duplicate if already present
    if (state.any((p) => p.id == post.id)) return;
    if (index != null && index >= 0 && index <= state.length) {
      final updated = [...state]..insert(index, post);
      state = updated;
    } else {
      state = [...state, post];
    }
  }

  void resetPosts() {
    state = createInitialNewsfeedPosts();
  }

  void toggleLike(String postId) {
    state = state.map((post) {
      if (post.id == postId) {
        final newIsLiked = !post.isLiked;
        final newLikeCount = newIsLiked
            ? post.likeCount + 1
            : (post.likeCount > 0 ? post.likeCount - 1 : 0);
        return post.copyWith(
          isLiked: newIsLiked,
          likeCount: newLikeCount,
        );
      }
      return post;
    }).toList();
  }

  void addComment(String postId, PostComment comment) {
    state = state.map((post) {
      if (post.id == postId) {
        final updatedComments = [...post.comments, comment];
        return post.copyWith(
          comments: updatedComments,
          commentCount: updatedComments.length,
        );
      }
      return post;
    }).toList();
  }

  void deletePost(String postId) {
    state = state.where((post) => post.id != postId).toList();
  }
}

final newsfeedControllerProvider =
    NotifierProvider<NewsfeedController, List<UserPost>>(() {
  return NewsfeedController();
});

class FollowRelationsNotifier extends Notifier<Set<String>> {
  @override
  Set<String> build() {
    // Initially follow authors present in the newsfeed
    return {'Helen Chen', 'Marcus Vance'};
  }

  bool isFollowing(String authorName) => state.contains(authorName);

  void follow(String authorName) {
    state = {...state, authorName};
  }

  void unfollow(String authorName) {
    state = {...state}..remove(authorName);
  }

  void toggleFollow(String authorName) {
    if (state.contains(authorName)) {
      unfollow(authorName);
    } else {
      follow(authorName);
    }
  }
}

final followRelationsProvider =
    NotifierProvider<FollowRelationsNotifier, Set<String>>(() {
  return FollowRelationsNotifier();
});
