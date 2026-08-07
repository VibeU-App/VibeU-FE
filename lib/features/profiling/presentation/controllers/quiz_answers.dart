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
  
  factory QuizAnswers.fromJson(Map<String, dynamic> json) => _$QuizAnswersFromJson(json);
}
