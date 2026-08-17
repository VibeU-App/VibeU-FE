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
  void updateTags(List<VibeTag> newTags) => state = state.copyWith(tags: newTags);
}
