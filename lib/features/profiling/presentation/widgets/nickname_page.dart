import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:vibeu_fe/config/UI/design_system.dart';

import '../widgets/header.dart';
import '../widgets/nickname_field.dart';

class NicknamePage extends HookConsumerWidget {
  const NicknamePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      spacing: AppSizes.s24,
      children: [
        const Header(
          title: "Nickname",
          subTitle: "Add your nickname so your friends can find you",
        ),

        Container(
          height: 75.0,
          width: 75.0,
          decoration: BoxDecoration(
            borderRadius: const .all(.circular(AppSizes.r999)),
          ),
          child: const Image(
            image: AssetImage(AppAssets.otp),
            height: 132.0,
          ),
        ),

        NicknameField(),
      ]
    );
  }
}
