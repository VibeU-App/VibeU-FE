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

// --- IMPORT CÁC THỨ ĐÃ ĐƯỢC TÁCH RA ---
import 'package:vibeu_fe/features/Me/presentation/widgets/vibe_bottom_nav_bar.dart';
import 'package:vibeu_fe/features/posts/presentation/widgets/vibe_post_card.dart';
import 'package:vibeu_fe/routing/routes.dart';

class MeView extends HookConsumerWidget {
  final bool showBottomNavBar;
  const MeView({super.key, this.showBottomNavBar = true});

  static const double avatarSize = 81.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    useListenable(scrollController);
    
    double offset = scrollController.hasClients ? scrollController.offset : 0.0;
    double scale = (1.0 - (offset / 150)).clamp(0.6, 1.0);
    double opacity = (1.0 - (offset / 150)).clamp(0.0, 1.0);

    return Scaffold(
      extendBody: true,
      body: BackgroundGradient(
        padding: EdgeInsets.zero,
        wrapWithScaffold: false,
        safeAreaTop: false,
        safeAreaBottom: false,
        child: SafeArea(
          bottom: false, // Let content scroll under the bottom nav bar
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.only(left: AppSizes.s24, right: AppSizes.s24, top: AppSizes.s24),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    // Top Bar: Settings
                    Padding(
                      padding: const EdgeInsets.only(top: AppSizes.s16),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: BouncyButton(
                          onPressed: () => context.push(Routes.meSettings),
                          child: Container(
                            padding: const EdgeInsets.all(AppSizes.s4),
                            child: const Icon(Hicons.settingLightOutline, size: AppSizes.s32, color: AppColors.textBody900),
                          ),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: AppSizes.s16 - AppSizes.s4),

                    // Parallax Header
                    Transform.scale(
                      scale: scale,
                      alignment: Alignment.topCenter,
                      child: Opacity(
                        opacity: opacity,
                        child: Column(
                          children: [
                            EntranceFader(
                              delay: AppDurations.superFast,
                              child: Center(
                                child: GestureDetector(
                                  onTap: () => context.push(Routes.meUpdateAvatar),
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
                            Center(
                              child: Consumer(
                                builder: (context, ref, _) => Text(
                                  ref.watch(meControllerProvider).nickname,
                                  style: AppTypography.h2.copyWith(color: AppColors.textPrimary500),
                                ),
                              ),
                            ),
                            const SizedBox(height: AppSizes.s4),
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
                                    const Icon(Icons.edit_outlined, size: 18, color: AppColors.textBody900),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: AppSizes.s32),

                    Text('My Tags', style: AppTypography.h3.copyWith(color: AppColors.textBody900)),
                    const SizedBox(height: AppSizes.s16 - AppSizes.s4),
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

                    Center(
                      child: BouncyButton(
                        onPressed: () => context.push(Routes.meUpdateTags),
                        child: Container(
                          width: AppSizes.s20,
                          height: AppSizes.s20,
                          decoration: const BoxDecoration(color: AppColors.surface600, shape: BoxShape.circle),
                          child: const Icon(Icons.add, color: AppColors.textBody900, size: AppSizes.s12),
                        ),
                      ),
                    ),

                    const SizedBox(height: AppSizes.s12),

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
              
              SliverToBoxAdapter(
                child: Container(height: 1, color: AppColors.textBody900, width: double.infinity),
              ),
              
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.s24),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    const SizedBox(height: AppSizes.s24),
                    Text('Share interesting moments', style: AppTypography.caption.copyWith(color: AppColors.textBody900)),
                    const SizedBox(height: AppSizes.s16 - AppSizes.s4),

                    BouncyButton(
                      onPressed: () => context.push(Routes.createPost),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomPaint(
                            painter: DashedRectPainter(color: AppColors.textBody900, strokeWidth: 1, gap: 4),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: AppSizes.s32, height: AppSizes.s32,
                                    decoration: BoxDecoration(border: Border.all(color: AppColors.textBody900, width: 2), borderRadius: BorderRadius.circular(4)),
                                    child: const Icon(Icons.image_outlined, size: AppSizes.s16, color: AppColors.textBody900),
                                  ),
                                  const SizedBox(width: AppSizes.s16 - AppSizes.s4),
                                  Text('Image', style: AppTypography.h3.copyWith(color: AppColors.textBody900, fontWeight: FontWeight.w700)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppSizes.s32),

                    // --- SỬ DỤNG VIBE_POST_CARD ĐÃ TÁCH ---
                    Consumer(
                      builder: (context, ref, _) {
                        final posts = ref.watch(meControllerProvider).posts;
                        if (posts.isEmpty) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: AppSizes.s32),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.photo_library_outlined,
                                    size: 40,
                                    color: AppColors.textMuted400,
                                  ),
                                  const SizedBox(height: AppSizes.s12),
                                  Text(
                                    'No moments shared yet',
                                    style: AppTypography.bodySmall.copyWith(
                                      color: AppColors.textMuted500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }

                        return Column(
                          children: posts.asMap().entries.map((entry) {
                            final index = entry.key;
                            final post = entry.value;
                            return EntranceFader(
                              delay: AppDurations.superFast * (index + 1),
                              child: VibePostCard(post: post),
                            );
                          }).toList(),
                        );
                      },
                    ),

                    const SizedBox(height: 120), // Extra padding so last item clears the nav bar
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),

      // --- SỬ DỤNG VIBE_BOTTOM_NAV_BAR ĐÃ TÁCH ---
      bottomNavigationBar: showBottomNavBar
          ? VibeBottomNavBar(
              selectedIndex: 4, // Đang ở trang Me (tab index 4)
              onItemTapped: (index) {
                if (index == 1) {
                  context.go(Routes.newsfeed);
                }
              },
            )
          : null,
    );
  }

  Future<void> _showEditBioBottomSheet(BuildContext context, WidgetRef ref) async {
    final currentState = ref.read(meControllerProvider);
    final result = await showAboutMeBottomSheet(context, initialValue: currentState.bio);
    if (result != null) {
      ref.read(meControllerProvider.notifier).updateBio(result);
    }
  }
}

// Các widget con nhỏ lẻ của trang Me giữ nguyên ở đây
class _TagChip extends StatelessWidget {
  final String label;
  final bool isHighlight;
  const _TagChip({required this.label, required this.isHighlight});

  @override
  Widget build(BuildContext context) {
    return BouncyButton(
      onPressed: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(color: isHighlight ? AppColors.accent500 : AppColors.surface600, borderRadius: BorderRadius.circular(AppSizes.r999)),
        child: Text(label, style: AppTypography.caption.copyWith(color: isHighlight ? AppColors.surface50 : AppColors.textBody900)),
      ),
    );
  }
}

class _StatButton extends StatelessWidget {
  final String label;
  final Color color;
  const _StatButton({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.s16, vertical: AppSizes.s8),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(AppSizes.r999)),
      child: Text(label, style: AppTypography.caption.copyWith(color: AppColors.surface50)),
    );
  }
}

class DashedRectPainter extends CustomPainter {
  final Color color; final double strokeWidth; final double gap;
  DashedRectPainter({required this.color, required this.strokeWidth, required this.gap});
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = color..strokeWidth = strokeWidth..style = PaintingStyle.stroke;
    var path = Path();
    var rect = RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, size.width, size.height), const Radius.circular(8));
    path.addRRect(rect);
    Path dashPath = Path();
    const dashWidth = 5.0; const dashSpace = 3.0; double distance = 0.0;
    for (PathMetric pathMetric in path.computeMetrics()) {
      while (distance < pathMetric.length) {
        dashPath.addPath(pathMetric.extractPath(distance, distance + dashWidth), Offset.zero);
        distance += dashWidth; distance += dashSpace;
      }
      distance = 0.0;
    }
    canvas.drawPath(dashPath, paint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
