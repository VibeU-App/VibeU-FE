import 'package:flutter/material.dart';
import 'package:vibeu_fe/config/UI/design_system.dart';

class UserPostFeed extends StatelessWidget {
  const UserPostFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: AppSizes.s16),
          height: 200,
          color: AppColors.background300,
          child: const Center(child: Text('Post Placeholder')),
        );
      },
    );
  }
}
