import 'package:flutter/material.dart';
import 'package:vibeu_fe/config/UI/design_system.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/create_post_app_bar.dart';
import '../widgets/create_post_input_area.dart';
import '../widgets/create_post_toolbar.dart';

class PostContentNotifier extends Notifier<String> {
  @override
  String build() => '';

  void updateContent(String newContent) {
    state = newContent;
  }
}

final postContentProvider = NotifierProvider<PostContentNotifier, String>(() {
  return PostContentNotifier();
});

class CreatePostView extends StatelessWidget {
  const CreatePostView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface50,
      appBar: const CreatePostAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            const Expanded(
              child: CreatePostInputArea(),
            ),
            // The toolbar will be pushed up by the keyboard automatically
            // because Scaffold handles resizeToAvoidBottomInset by default.
            const CreatePostToolbar(),
          ],
        ),
      ),
    );
  }
}
