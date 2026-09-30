import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vibeu_fe/config/UI/design_system.dart';
import 'package:vibeu_fe/features/Me/presentation/controllers/me_state.dart';
import 'package:vibeu_fe/features/newsfeed/presentation/controllers/newsfeed_controller.dart';
import 'package:vibeu_fe/features/newsfeed/presentation/widgets/newsfeed_post_options_sheet.dart';
import 'package:vibeu_fe/routing/routes.dart';

class NewsfeedPostCard extends ConsumerWidget {
  final UserPost post;

  const NewsfeedPostCard({
    super.key,
    required this.post,
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
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.textBody900.withValues(alpha: 0.12),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Author row: Avatar + Name + Timestamp + 3-dots menu
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.background300,
                backgroundImage: NetworkImage(
                  post.authorAvatar != null && post.authorAvatar!.isNotEmpty
                      ? post.authorAvatar!
                      : 'https://api.dicebear.com/9.x/avataaars/png?seed=${post.authorName}',
                ),
              ),
              const SizedBox(width: AppSizes.s12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.authorName,
                      style: AppTypography.bodyStd.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary900,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      post.timestamp,
                      style: AppTypography.caption.copyWith(
                        color: const Color(0xFF64748B),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.more_horiz, color: AppColors.textBody900, size: 22),
                splashRadius: 20,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () {
                  showNewsfeedPostOptionsSheet(
                    context: context,
                    ref: ref,
                    post: post,
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: AppSizes.s12),

          // 2. Post Content Text (Tap to view comments)
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: navigateToComments,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.contentText,
                  style: AppTypography.bodyStd.copyWith(
                    color: AppColors.textBody900,
                    height: 1.45,
                    fontSize: 15,
                  ),
                ),
                if (post.imagePath != null && post.imagePath!.isNotEmpty) ...[
                  const SizedBox(height: AppSizes.s12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.network(
                      post.imagePath!,
                      width: double.infinity,
                      height: 210,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: double.infinity,
                        height: 180,
                        color: AppColors.background300,
                        child: const Icon(
                          Icons.image_not_supported_outlined,
                          color: AppColors.textBody900,
                          size: 32,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: AppSizes.s16),

          // Subtle divider before action row
          Container(
            height: 1,
            color: AppColors.textBody900.withValues(alpha: 0.06),
            width: double.infinity,
          ),
          const SizedBox(height: AppSizes.s8),

          // 3. Action Row: Heart + Like Count, Comment + Comment Count
          Row(
            children: [
              // Like Button
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  ref.read(newsfeedControllerProvider.notifier).toggleLike(post.id);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.s8,
                    vertical: AppSizes.s4,
                  ),
                  child: Row(
                    children: [
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        transitionBuilder: (child, animation) =>
                            ScaleTransition(scale: animation, child: child),
                        child: Icon(
                          post.isLiked ? Icons.favorite : Icons.favorite_border,
                          key: ValueKey(post.isLiked),
                          size: 22,
                          color: post.isLiked
                              ? const Color(0xFFE11D48)
                              : AppColors.textBody900,
                        ),
                      ),
                      const SizedBox(width: AppSizes.s8),
                      Text(
                        '${post.likeCount}',
                        style: AppTypography.bodyStd.copyWith(
                          color: post.isLiked
                              ? const Color(0xFFE11D48)
                              : AppColors.textBody900,
                          fontWeight:
                              post.isLiked ? FontWeight.w700 : FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: AppSizes.s16),

              // Comment Button
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: navigateToComments,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.s8,
                    vertical: AppSizes.s4,
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.chat_bubble_outline,
                        size: 22,
                        color: AppColors.textBody900,
                      ),
                      const SizedBox(width: AppSizes.s8),
                      Text(
                        '${post.commentCount}',
                        style: AppTypography.bodyStd.copyWith(
                          color: AppColors.textBody900,
                          fontWeight: FontWeight.w500,
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
