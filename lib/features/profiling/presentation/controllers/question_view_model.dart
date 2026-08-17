class Question {
  final String id;
  final String title;
  final String question;
  final List<Answer> answers;

  const Question({
    required this.id,
    required this.title,
    required this.question,
    required this.answers,
  });
}

class Answer {
  final String id;
  final String answer;

  const Answer({
    required this.id,
    required this.answer,
  });
}
