import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:vibeu_fe/config/UI/design_system.dart';
import 'package:vibeu_fe/features/profiling/presentation/controllers/profiling_controller.dart';

import '../widgets/birthday_info.dart';
import '../widgets/birthday_scroll_view.dart';
import '../widgets/header.dart';

class BirthdayPage extends HookConsumerWidget {
  const BirthdayPage({super.key});

  static const birthdayInfoWidthRatio = 0.58;
  static const spaceRatio = 0.28;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screen = MediaQuery.sizeOf(context);
    final birthdayController = useMemoized(() => BirthdayInfoController());
    final birthdayText = useTextEditingController();
    return Column(
      children: [
        const Header(
          title: "Birthday",
          subTitle: "Just display information about your age",
        ),

        SizedBox(height: screen.height * spaceRatio),

        SizedBox(
          width: screen.width * birthdayInfoWidthRatio,
          child: BirthdayInfo(
            controller: birthdayText,
            birthday: birthdayController,
          )
        ),

        const SizedBox(height: AppSizes.s32),

        BirthdayScrollView(
          onBirthdayChanged: (date) {
            birthdayController.setBirthday(date);
            ref.read(profilingControllerProvider.notifier).setBirthday(date);
          },
        ),
      ]
    );
  }
}
