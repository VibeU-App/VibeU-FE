import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:vibeu_fe/config/UI/design_system.dart';
import 'package:vibeu_fe/config/dicebear/presets.dart';
import 'package:vibeu_fe/features/auth/presentation/widgets/vibe_outlined_button.dart';

import '../controllers/profiling_controller.dart';

import '../widgets/refresh_button.dart';
import '../widgets/header.dart';
import '../widgets/avatar_grid.dart';

class AvatarPage extends HookConsumerWidget {
  const AvatarPage({super.key});

  static const contentWidthRatio = 0.76;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final avatarGrid = useMemoized(() => AvatarGridController());

    return Column(
      spacing: AppSizes.s16,
      children: [
        const Header(
          title: 'Choose Your Sex',
          subTitle: 'You can’t change after confirming',
        ),

        SizedBox(
          width: screenWidth * contentWidthRatio,
          child: Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              VibeOutlinedButton(
                onPressed: () { avatarGrid.setPreset(malePreset); },
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
                onPressed: () { avatarGrid.setPreset(femalePreset); },
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
          )
        ),
       
        SizedBox.square(
          dimension: screenWidth * contentWidthRatio,
          child: AvatarGrid(
            controller: avatarGrid,
            onSelectedAvatar: () {
              ref.read(
                profilingControllerProvider.notifier
              ).setAvatar(avatarGrid.selected);
            }
          )
        ),

        ValueListenableBuilder(
          valueListenable: avatarGrid.isRefreshing,
          builder: (_, refresh, _) {
            return RefreshButton(
              text: 'Change',
              refresh: refresh,
              callback: () {
                avatarGrid.refresh();
              }
            );
          }
        )
      ]
    );
  }
}
