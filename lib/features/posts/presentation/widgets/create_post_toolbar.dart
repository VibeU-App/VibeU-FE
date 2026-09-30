import 'package:flutter/material.dart';
import 'package:vibeu_fe/config/UI/design_system.dart';
import 'package:vibeu_fe/features/Me/presentation/widgets/bouncy_button.dart';

class CreatePostToolbar extends StatelessWidget {
  const CreatePostToolbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: AppColors.surface50,
        border: Border(
          top: BorderSide(color: const Color(0xFFB5ABAC), width: 1),
          bottom: BorderSide(color: const Color(0xFFB5ABAC), width: 1),
        ),
      ),
      child: Row(
        children: [
          BouncyButton(
            onPressed: () {},
            child: const Icon(Icons.emoji_emotions_outlined, size: 24, color: Color(0xFF222124)),
          ),
          const SizedBox(width: 24),
          BouncyButton(
            onPressed: () {},
            child: const Icon(Icons.image_outlined, size: 24, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
