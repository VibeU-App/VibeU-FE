class Questionnaire {
  static List<Question Function()> get all => [q1, q2, q3, q4, q5];

  static Question q1() {
    return const Question(
      id: 'q1',
      title: 'Friday Night After a Deadline Week',
      question: 'After a full week of quizzes, presentations, and group deadlines, your friends ask you to go out on Friday night. What vibe would you choose?',
      answers: [
        .new(id: 'q1_a', answer: 'A quiet cafe with warm lighting where everyone can talk softly and decompress.'),
        .new(id: 'q1_b', answer: 'A new place you have never tried before: a workshop, student event, hidden cafe, or mini exhibition.'),
        .new(id: 'q1_c', answer: 'Something active like gym, running, football, bowling, or any plan that lets you burn energy.'),
        .new(id: 'q1_d', answer: 'Staying in, playing your comfort playlist, and texting only someone you genuinely trust.'),
      ]
    );
  }

  static Question q2() {
    return const Question(
      id: 'q2',
      title: 'When You Start Liking Someone in Class',
      question: 'You begin noticing someone from an elective class. You have only talked a few times. What would you most likely do?',
      answers: [
        .new(id: 'q2_a', answer: 'Start a casual conversation, send a class-related meme, then naturally suggest grabbing a drink after class.'),
        .new(id: 'q2_b', answer: 'Observe their vibe first, then slowly find a moment where the conversation feels natural.'),
        .new(id: 'q2_c', answer: 'Invite them into a low-pressure social setting, like a club event, game night, or group hangout.'),
        .new(id: 'q2_d', answer: 'Keep things soft and respectful; if they seem comfortable, you gradually take one more step.'),
      ]
    );
  }

  static Question q3() {
    return const Question(
      id: 'q3',
      title: 'Group Project Chaos',
      question: 'Your group presentation is coming soon, but the team is messy: late tasks, scattered files, and no clear direction. What role do you naturally take?',
      answers: [
        .new(id: 'q3_a', answer: 'Create a task list, assign responsibilities, and bring the team back on track.'),
        .new(id: 'q3_b', answer: 'Check in with each teammate to understand what is blocking them, then help redistribute the work.'),
        .new(id: 'q3_c', answer: 'Suggest a more creative direction so the group feels excited again.'),
        .new(id: 'q3_d', answer: 'Quietly organize the material, clean the slides, and make sure the foundation is solid.')
      ]
    );
  }

  static Question q4() {
    return const Question(
      id: 'q4',
      title: 'Quietly organize the material, clean the slides, and make sure the foundation is solid.',
      question: 'If you match with someone on VibeU, what kind of first meet-up sounds most like you?',
      answers: [
        .new(id: 'q4_a', answer: 'A slow walk, a small cafe, and a conversation that feels honest instead of performative.'),
        .new(id: 'q4_b', answer: 'A hands-on activity: pottery, board games, photobooth, exhibition, or a mini campus event.'),
        .new(id: 'q4_c', answer: 'A simple coffee or dinner plan where both people can be clear, present, and comfortable.'),
        .new(id: 'q4_d', answer: 'A casual group setting first so the energy feels natural and not too awkward.'),
      ]
    );
  }

  static Question q5() {
    return const Question(
      id: 'q5',
      title: 'What You Need in a Real Connection',
      question: 'When it comes to a relationship or close friendship, what matters most to you?',
      answers: [
        .new(id: 'q5_a', answer: 'A connection where both people can listen, understand, and hold space for each other\'s emotions.'),
        .new(id: 'q5_b', answer: 'A bond that keeps growing, where both people can change, improve, and become better versions of themselves.'),
        .new(id: 'q5_c', answer: 'Freedom and trust: being close without controlling each other\'s life, schedule, or identity.'),
        .new(id: 'q5_d', answer: 'Consistency: actions match words, no mixed signals, no emotional guessing games.'),
      ]
    );
  }
}

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
