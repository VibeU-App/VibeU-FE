import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vibeu_fe/config/UI/design_system.dart';
import 'package:vibeu_fe/features/Me/presentation/widgets/entrance_fader.dart';
import 'package:vibeu_fe/features/Me/presentation/widgets/vibe_bottom_nav_bar.dart';
import 'package:vibeu_fe/features/newsfeed/presentation/controllers/newsfeed_controller.dart';
import 'package:vibeu_fe/features/newsfeed/presentation/widgets/newsfeed_post_card.dart';
import 'package:vibeu_fe/routing/routes.dart';

class NewsfeedView extends HookConsumerWidget {
  final bool showBottomNavBar;
  const NewsfeedView({super.key, this.showBottomNavBar = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(newsfeedControllerProvider);
    final scrollController = useScrollController();

    return Scaffold(
      backgroundColor: const Color(0xFFFFF7F7),
      extendBody: true,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // --- TOP HEADER: "Newsfeed" ---
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.s24,
                vertical: AppSizes.s16,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF7F7),
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.textBody900.withValues(alpha: 0.1),
                    width: 1,
                  ),
                ),
              ),
              child: Text(
                'Newsfeed',
                style: AppTypography.h2.copyWith(
                  fontFamily: 'Outfit',
                  color: const Color(0xFF881337),
                  fontWeight: FontWeight.w700,
                  fontSize: 26,
                ),
              ),
            ),

            // --- POST FEED LIST ---
            Expanded(
              child: RefreshIndicator(
                color: AppColors.primary500,
                onRefresh: () async {
                  // Simulate refresh or re-fetch
                  await Future.delayed(const Duration(milliseconds: 500));
                },
                child: posts.isEmpty
                    ? ListView(
                        physics: const AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics(),
                        ),
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.55,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSizes.s32,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 72,
                                      height: 72,
                                      decoration: BoxDecoration(
                                        color: AppColors.primary500.withValues(alpha: 0.1),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.dynamic_feed_outlined,
                                        size: 36,
                                        color: AppColors.primary500,
                                      ),
                                    ),
                                    const SizedBox(height: AppSizes.s16),
                                    Text(
                                      'No posts to display',
                                      style: AppTypography.h3.copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.textPrimary900,
                                      ),
                                    ),
                                    const SizedBox(height: AppSizes.s8),
                                    Text(
                                      'You have hidden all posts or your feed is up to date.',
                                      textAlign: TextAlign.center,
                                      style: AppTypography.bodySmall.copyWith(
                                        color: AppColors.textMuted500,
                                      ),
                                    ),
                                    const SizedBox(height: AppSizes.s20),
                                    ElevatedButton.icon(
                                      onPressed: () {
                                        ref.read(newsfeedControllerProvider.notifier).resetPosts();
                                      },
                                      icon: const Icon(Icons.refresh_rounded, size: 18),
                                      label: const Text('Reset Feed'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.primary500,
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        elevation: 0,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 10,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : ListView.builder(
                        controller: scrollController,
                        physics: const AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics(),
                        ),
                        padding: const EdgeInsets.fromLTRB(
                          AppSizes.s16,
                          AppSizes.s16,
                          AppSizes.s16,
                          120, // Bottom padding for floating navigation bar
                        ),
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          final post = posts[index];
                          return EntranceFader(
                            key: ValueKey(post.id),
                            delay: Duration(milliseconds: 50 * (index + 1)),
                            child: NewsfeedPostCard(
                              key: ValueKey('post_${post.id}'),
                              post: post,
                            ),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),

      // --- BOTTOM NAV BAR (Compass index 1 active) ---
      bottomNavigationBar: showBottomNavBar
          ? VibeBottomNavBar(
              selectedIndex: 1,
              onItemTapped: (index) {
                if (index == 4) {
                  context.go(Routes.me);
                } else if (index == 1) {
                  if (scrollController.hasClients) {
                    scrollController.animateTo(
                      0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    );
                  }
                }
              },
            )
          : null,
    );
  }
}
