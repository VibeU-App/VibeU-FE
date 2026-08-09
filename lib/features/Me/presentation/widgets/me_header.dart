import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vibeu_fe/config/UI/design_system.dart';

class MeHeader extends StatelessWidget {
  final String avatarSeed;
  final String nickname;
  final String bio;

  const MeHeader({
    super.key,
    required this.avatarSeed,
    required this.nickname,
    required this.bio,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: AppColors.background300,
          child: SvgPicture.network(
            'https://api.dicebear.com/9.x/avataaars/svg?seed=$avatarSeed',
          ),
        ),
        const SizedBox(height: AppSizes.s8),
        Text(nickname, style: AppTypography.h1),
        Text(bio, style: AppTypography.bodyStd),
      ],
    );
  }
}
