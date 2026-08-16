import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'profiling_state.dart';
import 'quiz_answers.dart';

part 'profiling_controller.g.dart';

@Riverpod(keepAlive: true)
class ProfilingController extends _$ProfilingController {
  @override
  ProfilingState build() {
    return const ProfilingState(profile: Profile());
  }

  void setAvatar(String? seed, Gender? gender) {
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

  Future<void> fetchCategories() async {
  }
}

@Riverpod(keepAlive: true)
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

  Future<void> finalize() async {
    // TODO implement finalize()
  }
}
