import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:vibeu_fe/config/UI/design_system.dart';

class BirthdayInfoController extends ValueNotifier<DateTime> {
  BirthdayInfoController() : super(DateTime.now());

  void setBirthday(DateTime date) {
    value = date;
  }
}

class BirthdayInfo extends HookWidget {
  BirthdayInfo({
    super.key,
    required this.controller,
    required this.birthday,
  });

  final TextEditingController controller;
  final ValueNotifier<DateTime> birthday;
  final _signs = [
    (119, 'Capricorn'),
    (218, 'Aquarius'),
    (320, 'Pisces'),
    (419, 'Aries'),
    (520, 'Taurus'),
    (620, 'Gemini'),
    (722, 'Cancer'),
    (822, 'Leo'),
    (922, 'Virgo'),
    (1022, 'Libra'),
    (1121, 'Scorpio'),
    (1221, 'Sagittarius'),
    (1231, 'Capricorn'),
  ];

  @override
  Widget build(BuildContext context) {
    useValueListenable(birthday);

    useEffect(() {
      final age = _calculateAge(birthday.value);
      final plural = age == 1 ? "s" : "";
      final sign = _getZodiacSign(birthday.value);

      controller.text = "$age year$plural old, $sign";
      return null;
    }, [birthday.value]);

    return TextField(
      style: AppTypography.h3.copyWith(color: Colors.white),
      controller: controller,
      readOnly: true,
      enabled: false,
      textAlign: .center,
      decoration: const InputDecoration(
        filled: true,
        fillColor: AppColors.primary500,
        border: OutlineInputBorder(
          borderRadius: .all(.circular(AppSizes.r20)),
          borderSide: .none,
        )
      )
    );
  }

  int _calculateAge(DateTime birthday) {
    final now = DateTime.now();

    int age = now.year - birthday.year;
    if (now.month < birthday.month ||
        (now.month == birthday.month && now.day < birthday.day)) {
      age--;
    }
    return age;
  }

  String _getZodiacSign(DateTime date) {
    final value = date.month * 100 + date.day;

    for (final item in _signs) {
      final (val, sign) = item;
      if (value < val) return sign;
    }
    return 'Capricorn';
  }
}
