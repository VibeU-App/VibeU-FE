import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'me_controller.g.dart';

enum TagType { zodiac, personality, hobby, other }

class VibeTag {
  final String label;
  final TagType type;
  VibeTag({required this.label, required this.type});
}

class UserPost {
  final String id;
  final String timestamp;
  final String contentText;
  final String? imagePath;
  final int commentCount;
  final int likeCount;

  UserPost({
    required this.id,
    required this.timestamp,
    required this.contentText,
    this.imagePath,
    this.commentCount = 0,
    this.likeCount = 0,
  });
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
          timestamp: '11:30, 20/07/2026',
          contentText: 'Nội dung ở đây',
          imagePath: 'https://picsum.photos/400/200',
          commentCount: 2,
          likeCount: 1,
        ),
      ],
    );
  }

  void updateNickname(String newNickname) => state = state.copyWith(nickname: newNickname);
  void updateBio(String newBio) => state = state.copyWith(bio: newBio);
  void updateAvatar(String newSeed) => state = state.copyWith(avatarSeed: newSeed);
  void updateDob(DateTime newDob) => state = state.copyWith(dob: newDob);
}
