import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:vibeu_fe/config/UI/design_system.dart';

import '../widgets/birthday_info.dart';
import '../widgets/birthday_scroll_view.dart';
import '../widgets/header.dart';

class BirthdayPage extends HookConsumerWidget {
  const BirthdayPage({super.key});

  static const birthdayInfoWidthRatio = 0.58;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final birthdayController = useMemoized(() => BirthdayInfoController());
    final birthdayText = useTextEditingController();
    return Column(
      children: [
        const Header(
          title: "Birthday",
          subTitle: "Just display information about your age",
        ),

        const Spacer(),

        SizedBox(
          width: screenWidth * birthdayInfoWidthRatio,
          child: BirthdayInfo(
            controller: birthdayText,
            birthday: birthdayController,
          )
        ),

        const SizedBox(height: AppSizes.s32),

        Expanded(
          child: BirthdayScrollView(
            onBirthdayChanged: (date) {
              birthdayController.setBirthday(date);
            },
          )
        ),

        const SizedBox(height: AppSizes.s48),
      ]
    );
  }
}
