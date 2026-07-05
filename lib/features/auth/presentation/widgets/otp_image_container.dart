import 'package:flutter/material.dart';

import 'package:vibeu_fe/config/themes/design_system.dart';

class OtpImageContainer extends StatelessWidget {
  const OtpImageContainer({super.key});

  @override
  Widget build(BuildContext context) {
    // without a parent Column, the container spreads to fill out the list
    // element of the ListView.
    return Column(
      children: [
        Container(
          height: 204.0,
          width: 204.0,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                AppColors.background500,
                AppColors.surface500,
              ],
              begin: .topCenter,
              end: .bottomCenter,
            ),
            borderRadius: const .all(.circular(AppSizes.r999)),
            boxShadow: [AppShadows.mid]
          ),
          child: const Image(
            image: AssetImage(AppAssets.otp),
            height: 132.0,
          ),
        )
      ]
    );
  }
}
