import 'package:flutter/material.dart';

import 'package:vibeu_fe/config/UI/design_system.dart';
import 'package:vibeu_fe/features/auth/presentation/widgets/vibe_outlined_button.dart';

import '../widgets/refresh_button.dart';
import '../widgets/header.dart';
import '../widgets/avatar_grid.dart';

class AvatarPage extends StatefulWidget {
  const AvatarPage({super.key});

  @override
  State<AvatarPage> createState() => _AvatarPageState();
}

class _AvatarPageState extends State<AvatarPage> {
  late final ValueNotifier<bool> refresh;
  final grid = AvatarGridController();

  @override
  void initState() {
    super.initState();
    refresh = ValueNotifier(false);
  }

  @override
  void dispose() {
    refresh.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSizes.s16,
      children: [
        const Header(
          title: 'Choose Your Sex',
          subTitle: 'You can’t change after confirming',
        ),

        Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            VibeOutlinedButton(
              onPressed: () {},
              text: 'Male',
              textStyle: AppTypography.h3,
              icon: const Icon(
                Icons.male_rounded,
                size: AppSizes.s24,
              ),
              colorActivated: AppColors.primary500,
              shadow: [AppShadows.mid],
            ),

            VibeOutlinedButton(
              onPressed: () {},
              text: 'Female',
              textStyle: AppTypography.h3,
              icon: const Icon(
                Icons.female_rounded,
                size: AppSizes.s24,
              ),
              colorActivated: AppColors.primary500,
              shadow: [AppShadows.mid],
            )
          ]
        ),
       
        Expanded(
          child: AvatarGrid(
            controller: grid,
            onTap: () {},
            onRefresh: (value) { refresh.value = value; },
          ),
        ),

        ValueListenableBuilder(
          valueListenable: refresh,
          builder: (_, v, _) {
            return RefreshButton(
              text: 'Change',
              refresh: v,
              callback: () {
                if (refresh.value == true) return;
                grid.refresh();
              }
            );
          }
        ),
      ]
    );
  }
}
