import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vibeu_fe/config/UI/design_system.dart';
import 'package:vibeu_fe/features/Me/presentation/controllers/me_controller.dart';
import 'package:vibeu_fe/features/newsfeed/presentation/controllers/newsfeed_controller.dart';
import 'package:vibeu_fe/features/posts/presentation/widgets/post_action_menu.dart';

class PostCommentsView extends HookConsumerWidget {
  final UserPost post;

  const PostCommentsView({super.key, required this.post});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch current post from either MeController or NewsfeedController so updates reflect immediately
    final meState = ref.watch(meControllerProvider);
    final newsfeedPosts = ref.watch(newsfeedControllerProvider);
    final currentPost = meState.posts.firstWhere(
      (p) => p.id == post.id,
      orElse: () => newsfeedPosts.firstWhere(
        (p) => p.id == post.id,
        orElse: () => post,
      ),
    );
    final scrollController = useScrollController();

    void submitComment(String text) {
      if (text.isEmpty) return;

      final now = DateTime.now();
      final timeStr = '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';

      final newComment = PostComment(
        id: 'c_${DateTime.now().millisecondsSinceEpoch}',
        authorName: meState.nickname.isNotEmpty ? meState.nickname : 'Hungdepzai',
        authorAvatar: meState.avatarSeed,
        content: text,
        timestamp: timeStr,
      );

      ref.read(meControllerProvider.notifier).addComment(currentPost.id, newComment);
      ref.read(newsfeedControllerProvider.notifier).addComment(currentPost.id, newComment);

      // Scroll to bottom after adding comment
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (scrollController.hasClients) {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }

    return Scaffold(
      backgroundColor: AppColors.surface50,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            // --- HEADER (Figma Rectangle 210) ---
            Container(
              height: 74,
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.s16),
              decoration: BoxDecoration(
                color: const Color(0xFFE8E8E8),
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black.withValues(alpha: 0.1),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  // Back button
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black, size: 24),
                    onPressed: () => context.pop(),
                  ),
                  const SizedBox(width: AppSizes.s8),

                  // Post Author Avatar (48x48 rounded)
                  CircleAvatar(
                    radius: 24,
                    backgroundImage: NetworkImage(
                      currentPost.authorAvatar != null && currentPost.authorAvatar!.isNotEmpty
                          ? currentPost.authorAvatar!
                          : 'https://api.dicebear.com/9.x/avataaars/png?seed=${currentPost.authorName}',
                    ),
                    backgroundColor: const Color(0xFFD9D9D9),
                  ),
                  const SizedBox(width: AppSizes.s12),

                  // Author Info
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentPost.authorName,
                          style: AppTypography.caption.copyWith(
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontSize: 11,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          currentPost.timestamp,
                          style: AppTypography.caption.copyWith(
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 3-dots post config button (Anchored dropdown)
                  PostActionMenu(
                    isPinned: currentPost.isPinned,
                    iconColor: const Color(0xFF8C8C8C),
                    onPin: () {
                      ref.read(meControllerProvider.notifier).togglePinPost(currentPost.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(currentPost.isPinned ? 'Post unpinned' : 'Post pinned'),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                    onDelete: () {
                      ref.read(meControllerProvider.notifier).deletePost(currentPost.id);
                      ref.read(newsfeedControllerProvider.notifier).deletePost(currentPost.id);
                      context.pop();
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
            ),

            // --- CONTENT LIST (Post + Comments) ---
            Expanded(
              child: ListView(
                controller: scrollController,
                padding: EdgeInsets.zero,
                children: [
                  // Post content section with horizontal padding
                  Padding(
                    padding: const EdgeInsets.fromLTRB(AppSizes.s24, AppSizes.s16, AppSizes.s24, AppSizes.s24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Post caption
                        Text(
                          currentPost.contentText,
                          style: AppTypography.bodyStd.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),

                        // Post image (if present)
                        if (currentPost.imagePath != null && currentPost.imagePath!.isNotEmpty) ...[
                          const SizedBox(height: AppSizes.s12),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              currentPost.imagePath!,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(
                                width: double.infinity,
                                height: 180,
                                color: AppColors.background300,
                                child: const Icon(Icons.image_not_supported, color: AppColors.textBody900),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  // Edge-to-edge black divider like in Me page
                  Container(
                    height: 1,
                    color: AppColors.textBody900,
                    width: double.infinity,
                  ),

                  // Comments section with horizontal padding
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSizes.s24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: AppSizes.s16),

                        // "Comments" Title (Outfit 18px H3)
                        Text(
                          'Comments',
                          style: AppTypography.h3.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: AppSizes.s16),

                        // Comments list
                        if (currentPost.comments.isEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: AppSizes.s24),
                            child: Center(
                              child: Text(
                                'No comments yet. Be the first to comment!',
                                style: AppTypography.bodySmall.copyWith(
                                  color: AppColors.textMuted500,
                                ),
                              ),
                            ),
                          )
                        else
                          ...currentPost.comments.map((comment) => _CommentTile(comment: comment)),

                        const SizedBox(height: AppSizes.s32),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // --- BOTTOM COMMENT INPUT BAR ---
            _CommentInputBar(onSend: submitComment),
          ],
        ),
      ),
    );
  }
}

class _CommentInputBar extends StatefulWidget {
  final ValueChanged<String> onSend;

  const _CommentInputBar({required this.onSend});

  @override
  State<_CommentInputBar> createState() => _CommentInputBarState();
}

class _CommentInputBarState extends State<_CommentInputBar> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  bool _isComposing = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
    _controller.addListener(_handleTextChange);
  }

  void _handleTextChange() {
    final composing = _controller.text.trim().isNotEmpty;
    if (composing != _isComposing) {
      setState(() {
        _isComposing = composing;
      });
    }
  }

  void _submit() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    widget.onSend(text);
    _controller.clear();
    _focusNode.unfocus();
  }

  @override
  void dispose() {
    _controller.removeListener(_handleTextChange);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(AppSizes.s24, AppSizes.s8, AppSizes.s24, AppSizes.s16),
      decoration: BoxDecoration(
        color: AppColors.surface50,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Container(
        constraints: const BoxConstraints(
          minHeight: 46,
          maxHeight: 120,
        ),
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.s16, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: Colors.black.withValues(alpha: 0.8),
            width: 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Chat icon (shown when input is empty)
            if (!_isComposing)
              const Padding(
                key: ValueKey('chat_bubble_icon'),
                padding: EdgeInsets.only(bottom: 11, right: AppSizes.s8),
                child: Icon(
                  Icons.chat_bubble_outline,
                  size: 22,
                  color: Colors.black,
                ),
              ),

            // Expanding text field
            Expanded(
              key: const ValueKey('comment_input_expanded'),
              child: TextField(
                key: const ValueKey('comment_text_field'),
                focusNode: _focusNode,
                controller: _controller,
                minLines: 1,
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                style: AppTypography.bodySmall.copyWith(
                  color: const Color(0xFF1E293B),
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                  hintText: 'Comment something',
                  hintStyle: AppTypography.bodySmall.copyWith(
                    color: const Color(0xFF64748B),
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ),

            // Send paper-plane button (shown when text is present)
            if (_isComposing)
              GestureDetector(
                key: const ValueKey('comment_send_button'),
                onTap: _submit,
                child: Container(
                  padding: const EdgeInsets.only(bottom: 9, left: AppSizes.s4),
                  child: const Icon(
                    Icons.send_rounded,
                    size: 22,
                    color: Color(0xFF2563EB),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _CommentTile extends StatelessWidget {
  final PostComment comment;

  const _CommentTile({required this.comment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.s16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Commenter avatar (32x32 rounded)
          CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage(
              comment.authorAvatar != null && comment.authorAvatar!.isNotEmpty
                  ? (comment.authorAvatar!.startsWith('http')
                      ? comment.authorAvatar!
                      : 'https://api.dicebear.com/9.x/avataaars/png?seed=${comment.authorAvatar}')
                  : 'https://api.dicebear.com/9.x/avataaars/png?seed=${comment.authorName}',
            ),
            backgroundColor: const Color(0xFFD9D9D9),
          ),
          const SizedBox(width: AppSizes.s12),

          // Comment content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Username + Timestamp row
                Row(
                  children: [
                    Text(
                      comment.authorName,
                      style: AppTypography.caption.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: AppSizes.s8),
                    Text(
                      comment.timestamp,
                      style: AppTypography.caption.copyWith(
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF5B6A7E),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),

                // Comment message
                Text(
                  comment.content,
                  style: AppTypography.caption.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
