import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'package:vibeu_fe/config/UI/design_system.dart';

class NicknameField extends HookWidget {
  const NicknameField({super.key});

  @override
  Widget build(BuildContext context) {
    final nickname = useTextEditingController();

    return Container(
      height: 59.0,
      decoration: BoxDecoration(
        boxShadow: [AppShadows.low],
        color: Colors.white,
        borderRadius: const .all(.circular(AppSizes.s24)),
        border: .all(
          color: AppColors.surface700,
          width: 1.0,
        )
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: nickname,
              style: AppTypography.h2,
              textAlign: .center,
              decoration: InputDecoration(
                border: .none,
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              EvilIcons.close_o,
              color: AppColors.surface800,
            ),
            onPressed: () { nickname.clear(); }
          )
        ]
      )
    );
  }
}
