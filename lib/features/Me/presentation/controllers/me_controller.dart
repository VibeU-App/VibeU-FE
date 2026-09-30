import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'me_state.dart';
export 'me_state.dart';

part 'me_controller.g.dart';


@riverpod
class MeController extends _$MeController {
  @override
  MeState build() {
    return MeState(
      tags: [
        VibeTag(label: 'Taurus', type: TagType.zodiac),
        VibeTag(label: 'Lotus', type: TagType.personality),
        VibeTag(label: 'Introverted', type: TagType.other),
        VibeTag(label: 'Extroverted', type: TagType.other),
        VibeTag(label: 'Eccentric', type: TagType.other),
      ],
      posts: [
        UserPost(
          id: '1',
          authorName: 'abc123',
          timestamp: '11:30, 20/07/2026',
          contentText: 'Nội dung ở đây',
          imagePath: 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800',
          commentCount: 1,
          likeCount: 1,
          comments: [
            const PostComment(
              id: 'c1',
              authorName: 'abc',
              timestamp: '12:07',
              content: 'ABC123',
            ),
          ],
        ),
      ],
    );
  }

  void updateNickname(String newNickname) => state = state.copyWith(nickname: newNickname);
  void updateBio(String newBio) => state = state.copyWith(bio: newBio);
  void updateAvatar(String newSeed) => state = state.copyWith(avatarSeed: newSeed);
  void updateDob(DateTime newDob) => state = state.copyWith(dob: newDob);
  void updateTags(List<VibeTag> newTags) => state = state.copyWith(tags: newTags);

  void addPost(UserPost post) {
    final pinned = state.posts.where((p) => p.isPinned).toList();
    final nonPinned = state.posts.where((p) => !p.isPinned).toList();
    state = state.copyWith(posts: [...pinned, post, ...nonPinned]);
  }

  void toggleLike(String postId) {
    final updatedPosts = state.posts.map((post) {
      if (post.id == postId) {
        final newIsLiked = !post.isLiked;
        final newLikeCount = newIsLiked ? post.likeCount + 1 : (post.likeCount > 0 ? post.likeCount - 1 : 0);
        return post.copyWith(
          isLiked: newIsLiked,
          likeCount: newLikeCount,
        );
      }
      return post;
    }).toList();
    state = state.copyWith(posts: updatedPosts);
  }

  void addComment(String postId, PostComment comment) {
    final updatedPosts = state.posts.map((post) {
      if (post.id == postId) {
        final newComments = [...post.comments, comment];
        return post.copyWith(
          comments: newComments,
          commentCount: newComments.length,
        );
      }
      return post;
    }).toList();
    state = state.copyWith(posts: updatedPosts);
  }

  void deletePost(String postId) {
    final updatedPosts = state.posts.where((p) => p.id != postId).toList();
    state = state.copyWith(posts: updatedPosts);
  }

  void togglePinPost(String postId) {
    final updatedPosts = state.posts.map((post) {
      if (post.id == postId) {
        return post.copyWith(isPinned: !post.isPinned);
      }
      return post;
    }).toList();
    state = state.copyWith(posts: updatedPosts);
  }
}
