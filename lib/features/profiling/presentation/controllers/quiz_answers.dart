import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'quiz_answers.g.dart';

@JsonSerializable()
class QuizAnswers {
  final Map<String, String> answers;

  @JsonKey(includeToJson: false, includeFromJson: false)
  final AsyncValue? submission;

  const QuizAnswers({
    this.submission,
    required this.answers,
  });

  Map<String, dynamic> toJson() => _$QuizAnswersToJson(this);
}

@JsonSerializable()
class AnswerId {
  final String questionId;
  final String answerId;

  const AnswerId({
    required this.questionId,
    required this.answerId,
  });
}
