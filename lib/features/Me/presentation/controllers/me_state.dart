import 'package:vibeu_fe/features/posts/domain/models/post_comment.dart';
import 'package:vibeu_fe/utils/time_formatter.dart';
export 'package:vibeu_fe/features/posts/domain/models/post_comment.dart';

enum TagType { zodiac, personality, hobby, other }

class VibeTag {
  final String label;
  final TagType type;
  VibeTag({required this.label, required this.type});
}

class UserPost {
  final String id;
  final String authorName;
  final String? authorAvatar;
  final DateTime createdAt;
  final String contentText;
  final String? imagePath;
  final int commentCount;
  final int likeCount;
  final bool isPinned;
  final bool isLiked;
  final List<PostComment> comments;

  UserPost({
    required this.id,
    this.authorName = 'abc123',
    this.authorAvatar,
    DateTime? createdAt,
    String? timestamp,
    required this.contentText,
    this.imagePath,
    this.commentCount = 0,
    this.likeCount = 0,
    this.isPinned = false,
    this.isLiked = false,
    this.comments = const [],
  }) : createdAt = createdAt ?? DateTime.now();

  String get timestamp => formatRelativeTime(createdAt);

  UserPost copyWith({
    String? id,
    String? authorName,
    String? authorAvatar,
    DateTime? createdAt,
    String? timestamp,
    String? contentText,
    String? imagePath,
    int? commentCount,
    int? likeCount,
    bool? isPinned,
    bool? isLiked,
    List<PostComment>? comments,
  }) {
    return UserPost(
      id: id ?? this.id,
      authorName: authorName ?? this.authorName,
      authorAvatar: authorAvatar ?? this.authorAvatar,
      createdAt: createdAt ?? this.createdAt,
      contentText: contentText ?? this.contentText,
      imagePath: imagePath ?? this.imagePath,
      commentCount: commentCount ?? this.commentCount,
      likeCount: likeCount ?? this.likeCount,
      isPinned: isPinned ?? this.isPinned,
      isLiked: isLiked ?? this.isLiked,
      comments: comments ?? this.comments,
    );
  }
}

class MeState {
  final String avatarSeed;
  final String nickname;
  final String bio;
  final DateTime? dob;
  final List<VibeTag> tags;
  final List<UserPost> posts;
  final int swipedCount;
  final int matchedCount;

  MeState({
    this.avatarSeed = 'abc123',
    this.nickname = 'abc123',
    this.bio = 'Describe yourself in 1 sentence',
    this.dob,
    this.tags = const [],
    this.posts = const [],
    this.swipedCount = 0,
    this.matchedCount = 1,
  });

  MeState copyWith({
    String? avatarSeed,
    String? nickname,
    String? bio,
    DateTime? dob,
    List<VibeTag>? tags,
    List<UserPost>? posts,
    int? swipedCount,
    int? matchedCount,
  }) {
    return MeState(
      avatarSeed: avatarSeed ?? this.avatarSeed,
      nickname: nickname ?? this.nickname,
      bio: bio ?? this.bio,
      dob: dob ?? this.dob,
      tags: tags ?? this.tags,
      posts: posts ?? this.posts,
      swipedCount: swipedCount ?? this.swipedCount,
      matchedCount: matchedCount ?? this.matchedCount,
    );
  }
}
