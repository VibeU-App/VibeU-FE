import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:vibeu_fe/config/UI/design_system.dart';

import '../controllers/profiling_controller.dart';

import '../widgets/header.dart';
import '../widgets/avatar_slot.dart';
import '../widgets/nickname_field.dart';

class NicknamePage extends HookConsumerWidget {
  const NicknamePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nickname = useTextEditingController();
    final (seed, gender) = ref.watch(profilingControllerProvider.select((state) {
      final avatar =  state.profile.avatar;
      final gender = state.profile.gender;
      debugPrint('seed is $avatar, gender is $gender');
      return (avatar, gender);
    }));
    final animation = useAnimationController(
      duration: const Duration(milliseconds: 500),
    );

    useEffect(() {
      String? cur = ref.read(profilingControllerProvider).profile.nickname;
      if (cur != null) {
        nickname.text = cur;
      }
      animation.forward();
      return null;
    }, []);

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
          child: AvatarSlot(
            onPressed: () {},
            animation: animation,
            avatar: Avatar(gender: gender, seed: seed),
            iconSize: 75.0,
            selected: false
          )
        ),

        NicknameField(
          controller: nickname,
          onChanged: (name) {
            ref.read(
              profilingControllerProvider.notifier
            ).setNickname(name);
          },
        ),
      ]
    );
  }
}
