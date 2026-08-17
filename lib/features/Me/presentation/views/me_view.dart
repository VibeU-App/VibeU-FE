import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vibeu_fe/config/UI/design_system.dart';
import 'package:vibeu_fe/features/auth/presentation/widgets/background_gradient.dart';
import '../controllers/me_controller.dart';
import '../widgets/bouncy_button.dart';
import '../widgets/entrance_fader.dart';
import '../widgets/about_me_bottom_sheet.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_hicons/flutter_hicons.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class MeView extends HookConsumerWidget {
  const MeView({super.key});

  static const double avatarSize = 81.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Parallax controller
    final scrollController = useScrollController();
    useListenable(scrollController);
    
    // Calculate scale and opacity based on scroll offset
    double offset = scrollController.hasClients ? scrollController.offset : 0.0;
    // Shrink down to 60% when scrolled 150px
    double scale = (1.0 - (offset / 150)).clamp(0.6, 1.0);
    // Fade out to 0 when scrolled 150px
    double opacity = (1.0 - (offset / 150)).clamp(0.0, 1.0);

    return Scaffold(
      body: BackgroundGradient(
        child: SafeArea(
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.s24),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    // Top Bar: Settings
                    Padding(
                      padding: const EdgeInsets.only(top: AppSizes.s16),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: BouncyButton(
                          onPressed: () => context.go('/me/settings'),
                          child: Container(
                            padding: const EdgeInsets.all(AppSizes.s4),
                            child: const Icon(Hicons.settingLightOutline, size: AppSizes.s32, color: AppColors.textBody900),
                          ),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: AppSizes.s16 - AppSizes.s4),

                    // Parallax Header (Avatar + Nickname + Bio)
                    Transform.scale(
                      scale: scale,
                      alignment: Alignment.topCenter,
                      child: Opacity(
                        opacity: opacity,
                        child: Column(
                          children: [
                            // Avatar
                            EntranceFader(
                              delay: AppDurations.superFast,
                              child: Center(
                                child: GestureDetector(
                                  onTap: () => context.push('/me/edit-profile/update-avatar'),
                                  child: Hero(
                                    tag: 'avatar_hero',
                                    child: Consumer(
                                      builder: (context, ref, _) => CircleAvatar(
                                        radius: avatarSize / 2,
                                        backgroundImage: NetworkImage(
                                          'https://api.dicebear.com/9.x/avataaars/png?seed='
                                          '${ref.watch(meControllerProvider).avatarSeed}',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: AppSizes.s16 - AppSizes.s4),
                            // Nickname
                            Center(
                              child: Consumer(
                                builder: (context, ref, _) => Text(
                                  ref.watch(meControllerProvider).nickname,
                                  style: AppTypography.h2.copyWith(color: AppColors.textPrimary500),
                                ),
                              ),
                            ),
                            const SizedBox(height: AppSizes.s4),
                            // Bio (tap -> show edit bottom sheet)
                            Center(
                              child: BouncyButton(
                                onPressed: () => _showEditBioBottomSheet(context, ref),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Consumer(
                                      builder: (context, ref, _) {
                                        final state = ref.watch(meControllerProvider);
                                        return Text(
                                          state.bio,
                                          style: AppTypography.bodyStd.copyWith(color: AppColors.textBody900),
                                        );
                                      },
                                    ),
                                    const SizedBox(width: AppSizes.s8),
                                    const Icon(
                                      Icons.edit_outlined,
                                      size: 18,
                                      color: AppColors.textBody900,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: AppSizes.s32),

                    // My Tags label
                    Text(
                      'My Tags',
                      style: AppTypography.h3.copyWith(color: AppColors.textBody900),
                    ),

                    const SizedBox(height: AppSizes.s16 - AppSizes.s4),

                    // Tag chips
                    const Wrap(
                      spacing: 11,
                      runSpacing: 12,
                      children: [
                        _TagChip(label: 'Taurus', isHighlight: true),
                        _TagChip(label: 'Lotus', isHighlight: true),
                        _TagChip(label: 'Introverted', isHighlight: false),
                        _TagChip(label: 'Extroverted', isHighlight: false),
                        _TagChip(label: 'Eccentric', isHighlight: false),
                      ],
                    ),

                    const SizedBox(height: AppSizes.s12),

                    // Add tag button
                    Center(
                      child: BouncyButton(
                        onPressed: () => context.push('/me/edit-profile/update-tags'),
                        child: Container(
                          width: AppSizes.s20,
                          height: AppSizes.s20,
                          decoration: const BoxDecoration(
                            color: AppColors.surface600,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.add, color: AppColors.textBody900, size: AppSizes.s12),
                        ),
                      ),
                    ),

                    const SizedBox(height: AppSizes.s12),

                    // Stats buttons
                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _StatButton(label: '0 swiped', color: AppColors.primary500),
                          const SizedBox(width: AppSizes.s16),
                          _StatButton(label: '1 matched', color: AppColors.primary500),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppSizes.s32),
                  ]),
                ),
              ),
              
              // Full Width Line Separator
              SliverToBoxAdapter(
                child: Container(
                  height: 1,
                  color: AppColors.textBody900,
                  width: double.infinity,
                ),
              ),
              
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.s24),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    const SizedBox(height: AppSizes.s24),

                    // Share moments label
                    Text(
                      'Share interesting moments',
                      style: AppTypography.caption.copyWith(color: AppColors.textBody900),
                    ),

                    const SizedBox(height: AppSizes.s16 - AppSizes.s4),

                    // Image picker button
                    BouncyButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomPaint(
                            painter: DashedRectPainter(
                              color: AppColors.textBody900,
                              strokeWidth: 1,
                              gap: 4,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: AppSizes.s32,
                                    height: AppSizes.s32,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppColors.textBody900,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: const Icon(
                                      Icons.image_outlined,
                                      size: AppSizes.s16,
                                      color: AppColors.textBody900,
                                    ),
                                  ),
                                  const SizedBox(width: AppSizes.s16 - AppSizes.s4),
                                  Text(
                                    'Image',
                                    style: AppTypography.h3.copyWith(
                                      color: AppColors.textBody900,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppSizes.s32),

                    // Feed (Staggered Entrance with multiple mock posts)
                    ...List.generate(3, (index) => EntranceFader(
                      delay: AppDurations.superFast * (index + 1),
                      child: const Padding(
                        padding: EdgeInsets.only(bottom: AppSizes.s16),
                        child: _PostCard(),
                      ),
                    )),

                    const SizedBox(height: AppSizes.s64 + AppSizes.s32),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),

      // Bottom Nav Bar
      bottomNavigationBar: _buildFloatingNavBar(context),
    );
  }

  Widget _buildFloatingNavBar(BuildContext context) {
    return const _GooeyFloatingNavBar();
  }

  Future<void> _showEditBioBottomSheet(BuildContext context, WidgetRef ref) async {
    final currentState = ref.read(meControllerProvider);
    final result = await showAboutMeBottomSheet(
      context,
      initialValue: currentState.bio,
    );
    if (result != null) {
      ref.read(meControllerProvider.notifier).updateBio(result);
    }
  }
}

// ---------------------------------------------------------
// NEW: Gooey Floating Nav Bar
// ---------------------------------------------------------
class _GooeyFloatingNavBar extends HookConsumerWidget {
  const _GooeyFloatingNavBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = useState<int>(4); // Default to Profile

    return Container(
      margin: const EdgeInsets.only(
        left: AppSizes.s24 - AppSizes.s4,
        right: AppSizes.s24 - AppSizes.s4,
        bottom: AppSizes.s24 - AppSizes.s4,
      ),
      height: 70,
      decoration: BoxDecoration(
        color: AppColors.surface50,
        borderRadius: BorderRadius.circular(35),
        border: Border.all(color: AppColors.textBody900, width: 1),
        boxShadow: [BoxShadow(color: AppColors.textBody900.withValues(alpha: 0.12), blurRadius: 10)],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final itemWidth = constraints.maxWidth / 5;
          const indicatorSize = 50.0;
          
          return Stack(
            children: [
              // Liquid indicator
              AnimatedPositioned(
                duration: AppDurations.moderate,
                curve: Curves.elasticOut,
                left: (itemWidth * selectedIndex.value) + (itemWidth - indicatorSize) / 2,
                top: (70 - 2 - indicatorSize) / 2, // 70 height - 2 borders
                child: Container(
                  width: indicatorSize,
                  height: indicatorSize,
                  decoration: BoxDecoration(
                    color: AppColors.primary500.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              
              // Icons
              Row(
                children: [
                  _NavBarItem(
                    icon: Icons.home_outlined,
                    activeIcon: Icons.home,
                    isActive: selectedIndex.value == 0,
                    width: itemWidth,
                    onTap: () => selectedIndex.value = 0,
                  ),
                  _NavBarItem(
                    icon: Icons.explore_outlined,
                    activeIcon: Icons.explore,
                    isActive: selectedIndex.value == 1,
                    width: itemWidth,
                    onTap: () => selectedIndex.value = 1,
                  ),
                  // Center (+) Button
                  SizedBox(
                    width: itemWidth,
                    child: Center(
                      child: BouncyButton(
                        onPressed: () {},
                        child: CircleAvatar(
                          backgroundColor: AppColors.primary500,
                          child: const Icon(Icons.add, color: AppColors.surface50),
                        ),
                      ),
                    ),
                  ),
                  _NavBarItem(
                    icon: Icons.chat_bubble_outline,
                    activeIcon: Icons.chat_bubble,
                    isActive: selectedIndex.value == 3,
                    width: itemWidth,
                    onTap: () => selectedIndex.value = 3,
                  ),
                  _NavBarItem(
                    icon: Icons.person_outline,
                    activeIcon: Icons.person,
                    isActive: selectedIndex.value == 4,
                    width: itemWidth,
                    onTap: () => selectedIndex.value = 4,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final IconData? activeIcon;
  final bool isActive;
  final double width;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.icon,
    this.activeIcon,
    required this.isActive,
    required this.width,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(
        width: width,
        height: 70, // match nav bar height
        child: Center(
          child: AnimatedSwitcher(
            duration: AppDurations.fast,
            transitionBuilder: (child, animation) {
              return ScaleTransition(
                scale: animation,
                child: child,
              );
            },
            child: Icon(
              isActive ? (activeIcon ?? icon) : icon,
              key: ValueKey(isActive),
              color: isActive ? AppColors.primary500 : AppColors.textBody900,
              size: isActive ? 28 : 24,
            ),
          ),
        ),
      ),
    );
  }
}

// _TagChip
class _TagChip extends StatelessWidget {
  final String label;
  final bool isHighlight;
  const _TagChip({required this.label, required this.isHighlight});

  @override
  Widget build(BuildContext context) {
    return BouncyButton(
      onPressed: () {}, // empty callback to trigger bounce effect on tap
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.s16, vertical: AppSizes.s8),
        decoration: BoxDecoration(
          color: isHighlight ? AppColors.accent500 : AppColors.surface600,
          borderRadius: BorderRadius.circular(AppSizes.r999),
        ),
        child: Text(
          label,
          style: AppTypography.caption.copyWith(
            color: isHighlight ? AppColors.surface50 : AppColors.textBody900,
          ),
        ),
      ),
    );
  }
}

// _StatButton
class _StatButton extends StatelessWidget {
  final String label;
  final Color color;
  const _StatButton({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.s16, vertical: AppSizes.s8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppSizes.r999),
      ),
      child: Text(
        label,
        style: AppTypography.caption.copyWith(color: AppColors.surface50),
      ),
    );
  }
}

// _PostCard (Group 246)
class _PostCard extends StatelessWidget {
  const _PostCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface500,
        border: Border.all(color: AppColors.textBody900, width: 1),
        borderRadius: BorderRadius.circular(AppSizes.r12),
        boxShadow: [
          AppShadows.low,
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: timestamp + more options
          Padding(
            padding: const EdgeInsets.fromLTRB(AppSizes.s16, AppSizes.s16, AppSizes.s16, 0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '11:30, 20/07/2026',
                    style: AppTypography.overline.copyWith(color: AppColors.textBody900),
                  ),
                ),
                const Icon(Icons.more_horiz, size: AppSizes.s20, color: AppColors.textBody900),
              ],
            ),
          ),

          // Content text
          Padding(
            padding: const EdgeInsets.fromLTRB(AppSizes.s16, AppSizes.s12, AppSizes.s16, 0),
            child: Text(
              'Nội dung ở đây',
              style: AppTypography.bodyStd.copyWith(color: AppColors.textBody900),
            ),
          ),

          // Image area (grey box)
          Padding(
            padding: const EdgeInsets.fromLTRB(AppSizes.s16, AppSizes.s12, AppSizes.s16, 0),
            child: Container(
              height: AppSizes.s64 + AppSizes.s64 - AppSizes.s8,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.surface600,
                borderRadius: BorderRadius.circular(AppSizes.r4),
              ),
              alignment: Alignment.center,
              child: Text(
                'Ảnh',
                style: AppTypography.bodyStd.copyWith(color: AppColors.textBody900),
              ),
            ),
          ),

          // Reaction row
          Padding(
            padding: const EdgeInsets.all(AppSizes.s16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 1),
                const Icon(Icons.chat_bubble_outline, size: AppSizes.s20, color: AppColors.textBody900),
                const SizedBox(width: AppSizes.s8),
                Text(
                  '0',
                  style: AppTypography.bodyStd.copyWith(color: AppColors.textBody900),
                ),
                const Spacer(flex: 2),
                BouncyButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      const Icon(Icons.favorite_border, size: AppSizes.s20, color: AppColors.textBody900),
                      const SizedBox(width: AppSizes.s8),
                      Text(
                        '0',
                        style: AppTypography.bodyStd.copyWith(color: AppColors.textBody900),
                      ),
                    ],
                  ),
                ),
                const Spacer(flex: 1),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Custom painter for dashed border
class DashedRectPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;

  DashedRectPainter({required this.color, required this.strokeWidth, required this.gap});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    var path = Path();
    var rect = RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, size.width, size.height), const Radius.circular(8));
    path.addRRect(rect);
    
    // Create dashed path
    Path dashPath = Path();
    const dashWidth = 5.0;
    const dashSpace = 3.0;
    double distance = 0.0;
    
    for (PathMetric pathMetric in path.computeMetrics()) {
      while (distance < pathMetric.length) {
        dashPath.addPath(
          pathMetric.extractPath(distance, distance + dashWidth),
          Offset.zero,
        );
        distance += dashWidth;
        distance += dashSpace;
      }
      distance = 0.0;
    }
    
    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
