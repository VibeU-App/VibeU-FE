import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vibeu_fe/config/UI/design_system.dart';
import 'package:vibeu_fe/features/Me/presentation/controllers/me_controller.dart';
import 'package:vibeu_fe/features/posts/presentation/widgets/post_action_menu.dart';
import 'package:vibeu_fe/routing/routes.dart';

class VibePostCard extends ConsumerWidget {
  final UserPost post;
  final VoidCallback? onLike;

  const VibePostCard({
    super.key,
    required this.post,
    this.onLike,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void navigateToComments() {
      context.push(Routes.postComments, extra: post);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: AppSizes.s16),
      padding: const EdgeInsets.all(AppSizes.s16),
      decoration: BoxDecoration(
        color: AppColors.surface50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.textBody900.withValues(alpha: 0.15), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top bar: Timestamp + Pinned badge + 3-dots Menu
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  if (post.isPinned) ...[
                    const Icon(Icons.push_pin, size: 14, color: AppColors.primary500),
                    const SizedBox(width: 4),
                  ],
                  Text(
                    post.timestamp,
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textBody900,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              // Anchored 3-dots popup menu
              PostActionMenu(
                isPinned: post.isPinned,
                onPin: () {
                  ref.read(meControllerProvider.notifier).togglePinPost(post.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(post.isPinned ? 'Post unpinned' : 'Post pinned'),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
                onDelete: () {
                  ref.read(meControllerProvider.notifier).deletePost(post.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Post deleted'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: AppSizes.s8),

          // Post Text (Tap to view comments)
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: navigateToComments,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.contentText,
                  style: AppTypography.bodyStd.copyWith(color: AppColors.textBody900),
                ),
                const SizedBox(height: AppSizes.s12),
                if (post.imagePath != null && post.imagePath!.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      post.imagePath!,
                      width: double.infinity,
                      height: 150,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: double.infinity,
                        height: 150,
                        color: AppColors.background300,
                        child: const Icon(Icons.image_not_supported, color: AppColors.textBody900),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: AppSizes.s16),

          // Bottom Action Row: Comment Count & Like Count
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Tap comment button to open Watch Comment screen
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: navigateToComments,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSizes.s8, vertical: AppSizes.s4),
                  child: Row(
                    children: [
                      const Icon(Icons.chat_bubble_outline, size: 22, color: AppColors.textBody900),
                      const SizedBox(width: AppSizes.s8),
                      Text('${post.commentCount}', style: AppTypography.bodyStd.copyWith(color: AppColors.textBody900)),
                    ],
                  ),
                ),
              ),
              // Interactive Like button
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  if (onLike != null) {
                    onLike!();
                  } else {
                    ref.read(meControllerProvider.notifier).toggleLike(post.id);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSizes.s8, vertical: AppSizes.s4),
                  child: Row(
                    children: [
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
                        child: Icon(
                          post.isLiked ? Icons.favorite : Icons.favorite_border,
                          key: ValueKey(post.isLiked),
                          size: 22,
                          color: post.isLiked ? const Color(0xFFE11D48) : AppColors.textBody900,
                        ),
                      ),
                      const SizedBox(width: AppSizes.s8),
                      Text(
                        '${post.likeCount}',
                        style: AppTypography.bodyStd.copyWith(
                          color: post.isLiked ? const Color(0xFFE11D48) : AppColors.textBody900,
                          fontWeight: post.isLiked ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

