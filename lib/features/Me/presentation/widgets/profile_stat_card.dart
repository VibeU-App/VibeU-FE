import 'package:flutter/material.dart';
import 'package:vibeu_fe/config/UI/design_system.dart';

class ProfileStatCard extends StatelessWidget {
  final String label;
  final String value;

  const ProfileStatCard({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: AppTypography.h2),
        Text(label, style: AppTypography.caption),
      ],
    );
  }
}
