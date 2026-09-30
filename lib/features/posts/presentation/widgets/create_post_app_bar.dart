import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vibeu_fe/config/UI/design_system.dart';
import 'package:vibeu_fe/features/Me/presentation/widgets/bouncy_button.dart';
import 'package:vibeu_fe/features/Me/presentation/controllers/me_controller.dart';
import 'package:vibeu_fe/features/newsfeed/presentation/controllers/newsfeed_controller.dart';
import 'package:vibeu_fe/features/posts/presentation/views/create_post_view.dart';

class CreatePostAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CreatePostAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.background300, width: 1)),
      ),
      child: AppBar(
        backgroundColor: AppColors.surface50,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: BouncyButton(
          onPressed: () => context.pop(),
          child: const Icon(Icons.arrow_back, color: AppColors.textPrimary900, size: 28),
        ),
        title: Text(
          'Posting',
          style: AppTypography.h2.copyWith(
            fontFamily: 'Outfit',
            color: const Color(0xFF881337), // Primary/primary-500 equivalent in screenshot
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24.0, top: 8, bottom: 8),
            child: Consumer(
              builder: (context, ref, _) {
                final postContent = ref.watch(postContentProvider);
                final isEnabled = postContent.trim().isNotEmpty;
                
                return BouncyButton(
                  onPressed: isEnabled ? () {
                    final meState = ref.read(meControllerProvider);
                    final newPost = UserPost(
                      id: 'post_${DateTime.now().millisecondsSinceEpoch}',
                      authorName: meState.nickname.isNotEmpty ? meState.nickname : 'Me',
                      authorAvatar: 'https://api.dicebear.com/9.x/avataaars/png?seed=${meState.avatarSeed}',
                      createdAt: DateTime.now(),
                      contentText: postContent.trim(),
                      imagePath: null,
                      commentCount: 0,
                      likeCount: 0,
                      isPinned: false,
                      isLiked: false,
                      comments: const [],
                    );

                    // Add to Me profile posts (at the top)
                    ref.read(meControllerProvider.notifier).addPost(newPost);
                    // Add to Newsfeed posts (at the top)
                    ref.read(newsfeedControllerProvider.notifier).addPost(newPost);

                    // Reset post content
                    ref.read(postContentProvider.notifier).updateContent('');

                    context.pop();
                  } : () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                      color: isEnabled ? const Color(0xFFE11D48) : AppColors.surface600,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Center(
                      child: Text(
                        'Post',
                        style: AppTypography.caption.copyWith(
                          color: isEnabled ? AppColors.surface50 : const Color(0xFF64748B),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                );
              }
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
