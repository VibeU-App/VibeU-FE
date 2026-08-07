import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'profiling_state.dart';
import 'quiz_answers.dart';

part 'profiling_controller.g.dart';

@riverpod
class ProfilingController extends _$ProfilingController {
  @override
  ProfilingState build() {
    return const ProfilingState(profile: Profile());
  }

  void setAvatar(String? seed, Gender gender) {
    state = ProfilingState(profile: state.profile.copyWith(avatar: seed, gender: gender));
  }

  void setNickname(String? nickname) {
    state = ProfilingState(profile: state.profile.copyWith(nickname: nickname));
  }

  void setBirthday(DateTime? birthday) {
    state = ProfilingState(profile: state.profile.copyWith(birthday: birthday));
  }

  void setTags(List<String>? tags) {
    state = ProfilingState(profile: state.profile.copyWith(tags: tags));
  }

  Gender? getGender() {
    return state.profile.gender;
  }

  String? getAvatarSeed() {
    return state.profile.avatar;
  }

  String? getNickname() {
    return state.profile.nickname;
  }

  List<String>? getTags() {
    return state.profile.tags;
  }

  Future<void> fetchCategories() async {
  }
}

@riverpod
class PersonalitySetup extends _$PersonalitySetup {
  @override
  QuizAnswers build() {
    return const QuizAnswers(answers: {});
  }

  void setAnswer(String questionId, String answerId) {
    state = QuizAnswers(
      answers: {
        ...state.answers,
        questionId: answerId,
      },
      submission: state.submission,
    );
  }

  String? getAnswer(String questionId) {
    return state.answers[questionId];
  }

  Future<void> finalize() async {
    state.toJson();
  }
}
