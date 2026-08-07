import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'package:vibeu_fe/config/UI/design_system.dart';

class NicknameField extends StatelessWidget {
  const NicknameField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
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
              controller: controller,
              onChanged: onChanged,
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
            onPressed: () {
              onChanged('');
              controller.clear();
            }
          )
        ]
      )
    );
  }
}
