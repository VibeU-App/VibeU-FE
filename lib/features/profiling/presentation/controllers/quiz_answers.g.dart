// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_answers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizAnswers _$QuizAnswersFromJson(Map<String, dynamic> json) =>
    QuizAnswers(answers: Map<String, String>.from(json['answers'] as Map));

Map<String, dynamic> _$QuizAnswersToJson(QuizAnswers instance) =>
    <String, dynamic>{'answers': instance.answers};

AnswerId _$AnswerIdFromJson(Map<String, dynamic> json) => AnswerId(
  questionId: json['questionId'] as String,
  answerId: json['answerId'] as String,
);

Map<String, dynamic> _$AnswerIdToJson(AnswerId instance) => <String, dynamic>{
  'questionId': instance.questionId,
  'answerId': instance.answerId,
};
