import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Gender {
  male, female
}

class ProfilingState {
  final Profile profile;
  final AsyncValue<void>? submission;

  const ProfilingState({
    required this.profile,
    this.submission,
  });
}

class Profile {
  const Profile({
    this.avatar,
    this.gender,
    this.nickname,
    this.birthday,
    this.tags,
  });

  final String? avatar;
  final Gender? gender;
  final String? nickname;
  final DateTime? birthday;
  final List<String>? tags;

  Profile copyWith({
    String? avatar,
    Gender? gender,
    String? nickname,
    DateTime? birthday,
    List<String>? tags,
  }) {
    return Profile(
      avatar: avatar ?? this.avatar,
      gender: gender ?? this.gender,
      nickname: nickname ?? this.nickname,
      birthday: birthday ?? this.birthday,
      tags: tags ?? this.tags,
    );
  }
}
