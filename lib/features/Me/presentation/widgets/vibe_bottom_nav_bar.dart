import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vibeu_fe/config/UI/design_system.dart';
import 'package:vibeu_fe/routing/routes.dart';
import 'bouncy_button.dart';

class VibeBottomNavBar extends HookConsumerWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;
  final VoidCallback? onPlusTapped;

  const VibeBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
    this.onPlusTapped,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final oldIndexState = useState(selectedIndex);
    final targetIndexState = useState(selectedIndex);
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 320),
    );

    useEffect(() {
      if (selectedIndex != targetIndexState.value) {
        oldIndexState.value = targetIndexState.value;
        targetIndexState.value = selectedIndex;
        controller.forward(from: 0.0);
      }
      return null;
    }, [selectedIndex]);

    return Padding(
      padding: const EdgeInsets.only(
        left: AppSizes.s24 - AppSizes.s4,
        right: AppSizes.s24 - AppSizes.s4,
        bottom: AppSizes.s24 - AppSizes.s4,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(35),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              color: AppColors.surface50.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(35),
              border: Border.all(color: AppColors.textBody900.withValues(alpha: 0.15), width: 1),
            ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final itemWidth = constraints.maxWidth / 5;
          const indicatorSize = 50.0;
          const maxIndicatorWidth = indicatorSize + 24.0;

          return Stack(
            children: [
              // Liquid stretch indicator (Hiệu ứng giọt nước giãn mượt mà)
              AnimatedBuilder(
                animation: controller,
                builder: (context, _) {
                  final fromIndex = oldIndexState.value;
                  final toIndex = targetIndexState.value;

                  final fromLeft = (itemWidth * fromIndex) + (itemWidth - indicatorSize) / 2;
                  final fromRight = fromLeft + indicatorSize;

                  final toLeft = (itemWidth * toIndex) + (itemWidth - indicatorSize) / 2;
                  final toRight = toLeft + indicatorSize;

                  final isMovingRight = toIndex >= fromIndex;
                  final progress = controller.isAnimating ? controller.value : 1.0;

                  // Mép dẫn dắt (lead) bay trước, mép sau (trail) theo sau để tạo độ giãn
                  final leadCurve = const Interval(0.0, 0.75, curve: Curves.easeOutCubic).transform(progress);
                  final trailCurve = const Interval(0.20, 1.0, curve: Curves.easeOutCubic).transform(progress);

                  double currentLeft;
                  double currentRight;

                  if (isMovingRight) {
                    currentRight = lerpDouble(fromRight, toRight, leadCurve)!;
                    currentLeft = lerpDouble(fromLeft, toLeft, trailCurve)!;
                    if (currentRight - currentLeft > maxIndicatorWidth) {
                      currentLeft = currentRight - maxIndicatorWidth;
                    }
                  } else {
                    currentLeft = lerpDouble(fromLeft, toLeft, leadCurve)!;
                    currentRight = lerpDouble(fromRight, toRight, trailCurve)!;
                    if (currentRight - currentLeft > maxIndicatorWidth) {
                      currentRight = currentLeft + maxIndicatorWidth;
                    }
                  }

                  final width = (currentRight - currentLeft).clamp(indicatorSize, constraints.maxWidth);

                  return Positioned(
                    left: currentLeft,
                    top: (70 - 2 - indicatorSize) / 2,
                    child: Container(
                      width: width,
                      height: indicatorSize,
                      decoration: BoxDecoration(
                        color: AppColors.primary500.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(indicatorSize / 2),
                      ),
                    ),
                  );
                },
              ),

              // Icons
              Row(
                children: [
                  _NavBarItem(
                    icon: Icons.home_outlined,
                    activeIcon: Icons.home,
                    isActive: selectedIndex == 0,
                    width: itemWidth,
                    onTap: () => onItemTapped(0),
                  ),
                  _NavBarItem(
                    icon: Icons.explore_outlined,
                    activeIcon: Icons.explore,
                    isActive: selectedIndex == 1,
                    width: itemWidth,
                    onTap: () => onItemTapped(1),
                  ),
                  // Center (+) Button
                  SizedBox(
                    width: itemWidth,
                    child: Center(
                      child: BouncyButton(
                        onPressed: () {
                          if (onPlusTapped != null) {
                            onPlusTapped!();
                          } else {
                            context.push(Routes.createPost);
                          }
                        },
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
                    isActive: selectedIndex == 3,
                    width: itemWidth,
                    onTap: () => onItemTapped(3),
                  ),
                  _NavBarItem(
                    icon: Icons.person_outline,
                    activeIcon: Icons.person,
                    isActive: selectedIndex == 4,
                    width: itemWidth,
                    onTap: () => onItemTapped(4),
                  ),
                ],
              ),
            ],
          );
        },
      ),
          ),
        ),
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
        height: 70,
        child: Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            switchInCurve: Curves.easeOutCubic,
            switchOutCurve: Curves.easeInCubic,
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
