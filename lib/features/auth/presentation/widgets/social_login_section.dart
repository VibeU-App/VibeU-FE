import 'package:flutter/material.dart';

import 'package:vibeu_fe/config/themes/design_system.dart';
import 'social_login_button.dart';

class SocialLoginSection extends StatelessWidget {
  final List<SocialLoginButton> socialLoginButtonList;

  const SocialLoginSection({
    super.key,
    required this.socialLoginButtonList,
  });

  @override
    Widget build(BuildContext context) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(child: Divider(color: AppColors.surface800)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.s24),
                child: Text(
                  'Or continue with',
                  style: AppTypography.bodySmall.copyWith(color: AppColors.surface800),
                ),
              ),
              Expanded(child: Divider(color: AppColors.surface800)),
            ],
          ),
          SizedBox(height: 20.0),
          Column(children: socialLoginButtonList),
        ]
      );
    }
}
