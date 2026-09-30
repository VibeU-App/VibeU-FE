import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vibeu_fe/config/UI/design_system.dart';
import 'package:vibeu_fe/features/Me/presentation/controllers/me_controller.dart';
import 'package:vibeu_fe/features/newsfeed/presentation/controllers/newsfeed_controller.dart';

Future<void> showNewsfeedPostOptionsSheet({
  required BuildContext context,
  required WidgetRef ref,
  required UserPost post,
}) async {
  // Capture ScaffoldMessenger before any pop or state modification to prevent deactivated context errors
  final messenger = ScaffoldMessenger.of(context);

  final meState = ref.read(meControllerProvider);
  final isOwner = post.authorName == meState.nickname ||
      post.authorName == 'Me' ||
      post.authorName == 'abc123' ||
      post.id.startsWith('post_');

  await showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.surface50,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (ctx) {
      return Consumer(
        builder: (context, ref, _) {
          final followedUsers = ref.watch(followRelationsProvider);
          final isFollowing = followedUsers.contains(post.authorName);

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Drag handle
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.textBody900.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 16),

                  if (isOwner) ...[
                    // --- OWNER OPTIONS ---
                    _OptionTile(
                      icon: post.isPinned ? Icons.push_pin : Icons.push_pin_outlined,
                      iconColor: AppColors.textBody900,
                      title: post.isPinned ? 'Unpin from profile' : 'Pin to profile',
                      subtitle: 'Keep this post featured at the top',
                      onTap: () {
                        Navigator.pop(ctx);
                        ref.read(meControllerProvider.notifier).togglePinPost(post.id);
                        messenger.clearSnackBars();
                        messenger.showSnackBar(
                          SnackBar(
                            content: Text(post.isPinned ? 'Post unpinned' : 'Post pinned to profile'),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                    ),
                    _OptionTile(
                      icon: Icons.delete_outline_rounded,
                      iconColor: const Color(0xFFE11D48),
                      textColor: const Color(0xFFE11D48),
                      title: 'Delete post',
                      subtitle: 'Permanently remove this post',
                      onTap: () {
                        Navigator.pop(ctx);
                        ref.read(newsfeedControllerProvider.notifier).deletePost(post.id);
                        ref.read(meControllerProvider.notifier).deletePost(post.id);
                        messenger.clearSnackBars();
                        messenger.showSnackBar(
                          const SnackBar(
                            content: Text('Post deleted'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                    ),
                  ] else ...[
                    // --- SOCIAL / OTHER USER'S POST OPTIONS ---
                    _OptionTile(
                      icon: Icons.visibility_off_outlined,
                      iconColor: AppColors.textBody900,
                      title: 'Hide post',
                      subtitle: 'See fewer posts like this on your feed',
                      onTap: () {
                        final newsfeedNotifier = ref.read(newsfeedControllerProvider.notifier);
                        final currentPosts = ref.read(newsfeedControllerProvider);
                        final postIndex = currentPosts.indexWhere((p) => p.id == post.id);

                        Navigator.pop(ctx);
                        newsfeedNotifier.deletePost(post.id);

                        messenger.clearSnackBars();
                        messenger.showSnackBar(
                          SnackBar(
                            content: const Text('Post hidden from your feed'),
                            action: SnackBarAction(
                              label: 'Undo',
                              textColor: AppColors.primary500,
                              onPressed: () {
                                newsfeedNotifier.restorePost(
                                  post,
                                  index: postIndex >= 0 ? postIndex : null,
                                );
                              },
                            ),
                            duration: const Duration(seconds: 4),
                          ),
                        );
                      },
                    ),
                    _OptionTile(
                      icon: isFollowing
                          ? Icons.person_remove_outlined
                          : Icons.person_add_outlined,
                      iconColor: AppColors.textBody900,
                      title: isFollowing
                          ? 'Unfollow ${post.authorName}'
                          : 'Follow ${post.authorName}',
                      subtitle: isFollowing
                          ? 'Stop seeing posts from this user'
                          : 'See posts from this user in your feed',
                      onTap: () {
                        Navigator.pop(ctx);
                        messenger.clearSnackBars();
                        if (isFollowing) {
                          ref.read(followRelationsProvider.notifier).unfollow(post.authorName);
                          messenger.showSnackBar(
                            SnackBar(
                              content: Text('You unfollowed ${post.authorName}'),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        } else {
                          ref.read(followRelationsProvider.notifier).follow(post.authorName);
                          messenger.showSnackBar(
                            SnackBar(
                              content: Text('You are now following ${post.authorName}'),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                    ),
                    _OptionTile(
                      icon: Icons.link_rounded,
                      iconColor: AppColors.textBody900,
                      title: 'Copy link',
                      subtitle: 'Copy link to share with friends',
                      onTap: () {
                        Navigator.pop(ctx);
                        Clipboard.setData(ClipboardData(text: 'https://vibeu.app/p/${post.id}'));
                        messenger.clearSnackBars();
                        messenger.showSnackBar(
                          const SnackBar(
                            content: Text('Link copied to clipboard!'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                    ),
                    const Divider(height: 16, indent: 24, endIndent: 24),
                    _OptionTile(
                      icon: Icons.flag_outlined,
                      iconColor: const Color(0xFFE11D48),
                      textColor: const Color(0xFFE11D48),
                      title: 'Report post',
                      subtitle: 'Tell us about an issue with this post',
                      onTap: () {
                        Navigator.pop(ctx);
                        _showReportDialog(context, messenger, post);
                      },
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

void _showReportDialog(BuildContext context, ScaffoldMessengerState messenger, UserPost post) {
  final reportReasons = [
    'Spam or scam',
    'Inappropriate or adult content',
    'Harassment or hate speech',
    'False information',
    'Violence or dangerous organizations',
    'Something else',
  ];

  showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.surface50,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (ctx) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.textBody900.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Report post',
                style: AppTypography.h3.copyWith(
                  color: const Color(0xFF881337),
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Why are you reporting this post by ${post.authorName}?',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textMuted500,
                ),
              ),
              const SizedBox(height: 16),
              ...reportReasons.map((reason) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(
                    Icons.radio_button_unchecked,
                    color: AppColors.textBody900,
                    size: 20,
                  ),
                  title: Text(
                    reason,
                    style: AppTypography.bodyStd.copyWith(
                      color: AppColors.textPrimary900,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(ctx);
                    messenger.clearSnackBars();
                    messenger.showSnackBar(
                      SnackBar(
                        content: Text('Report submitted: "$reason". Thank you for helping keep VibeU safe.'),
                        backgroundColor: const Color(0xFF1E293B),
                        duration: const Duration(seconds: 3),
                      ),
                    );
                  },
                );
              }),
            ],
          ),
        ),
      );
    },
  );
}

class _OptionTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color? textColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _OptionTile({
    required this.icon,
    required this.iconColor,
    this.textColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 22),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.bodyStd.copyWith(
                      color: textColor ?? AppColors.textPrimary900,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: AppTypography.caption.copyWith(
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: Color(0xFF94A3B8),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
