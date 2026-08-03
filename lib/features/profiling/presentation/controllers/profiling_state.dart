import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    this.nickname,
    this.birthday,
    this.tags,
  });

  final Widget? avatar;
  final String? nickname;
  final DateTime? birthday;
  final List<String>? tags;

  Profile copyWith({
    Widget? avatar,
    String? nickname,
    DateTime? birthday,
    List<String>? tags,
  }) {
    return Profile(
      avatar: avatar ?? this.avatar,
      nickname: nickname ?? this.nickname,
      birthday: birthday ?? this.birthday,
      tags: tags ?? this.tags,
    );
  }
}
