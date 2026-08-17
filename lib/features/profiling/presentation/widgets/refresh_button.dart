import 'package:flutter/material.dart';
import 'package:flutter_hicons/flutter_hicons.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:vibeu_fe/config/UI/design_system.dart';

class RefreshButton extends HookWidget {
  final String text;
  final bool refresh;
  final VoidCallback callback;

  const RefreshButton({
    super.key,
    required this.text,
    required this.refresh,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    final animation = useAnimationController(
      duration: const Duration(seconds: 1),
    );

    useEffect(() {
      if (refresh) {
        animation.repeat();
      } else {
        animation.reset();
      }
      return null;
    }, [refresh]);

    return TextButton.icon(
      onPressed: callback,
      label: Text(
        text,
        style: AppTypography.h3.copyWith(
          color: AppColors.textMuted500,
        ),
      ),
      icon: RotationTransition(
        turns: CurvedAnimation(
          parent: animation,
          curve: Curves.fastLinearToSlowEaseIn,
        ),
        child: const Icon(
          Hicons.refresh2LightOutline,
          size: AppSizes.s24,
        )
      )
    );
  }
}
