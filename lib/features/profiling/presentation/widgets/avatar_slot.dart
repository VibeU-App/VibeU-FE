import 'package:flutter/material.dart';
import 'package:dice_bear/dice_bear.dart';

import 'package:vibeu_fe/config/UI/design_system.dart';
import 'package:vibeu_fe/config/dicebear/dicebear.dart';
import 'package:vibeu_fe/config/dicebear/presets.dart';

import '../controllers/profiling_state.dart';

class Avatar {
  const Avatar({this._seed, required this._gender});

  final String? _seed;
  final Gender? _gender;

  String? get seed => _seed;
  Gender? get gender => _gender;

  DiceBearPersonasOptions getGenderPreset() {
    switch (_gender) {
      case .male:
        return malePreset;
      case .female:
      default:
        return femalePreset;
    }
  }
}

class AvatarSlot extends StatelessWidget {
  final VoidCallback onPressed;
  final Animation<double> animation;
  final Avatar avatar;
  final double iconSize;
  final bool selected;

  const AvatarSlot({
    super.key,
    required this.onPressed,
    required this.animation,
    required this.avatar,
    required this.iconSize,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: CurvedAnimation(parent: animation, curve: Curves.easeInOut),
      child: IconButton.outlined(
        iconSize: iconSize,
        icon: avatar._seed == null
            ? SizedBox()
            : diceBearAvatar(avatar._seed!, avatar.getGenderPreset()),
        onPressed: onPressed,
        color: AppColors.background900,
        style: IconButton.styleFrom(
          splashFactory: NoSplash.splashFactory,
          side: BorderSide(
            color: selected ? AppColors.primary500 : Colors.transparent,
          ),
        ),
      ),
    );
  }
}
