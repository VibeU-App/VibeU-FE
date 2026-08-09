import 'package:flutter/material.dart';
import 'package:vibeu_fe/config/UI/design_system.dart';
import '../controllers/me_controller.dart';

class VibeTagSection extends StatelessWidget {
  final List<VibeTag> tags;

  const VibeTagSection({super.key, required this.tags});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSizes.s8,
      children: tags.map((tag) {
        final isHighlight = tag.type == TagType.zodiac || tag.type == TagType.personality;
        return Chip(
          label: Text(tag.label),
          backgroundColor: isHighlight ? AppColors.accent500 : AppColors.surface800,
          labelStyle: TextStyle(color: isHighlight ? AppColors.surface50 : AppColors.textBody500),
        );
      }).toList(),
    );
  }
}
