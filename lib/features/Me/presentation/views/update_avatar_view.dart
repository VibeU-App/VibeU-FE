import 'dart:math'; // Thêm thư viện math để dùng Random
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vibeu_fe/config/UI/design_system.dart';
import 'package:vibeu_fe/features/auth/presentation/widgets/background_gradient.dart';
import '../controllers/me_controller.dart';

class UpdateAvatarView extends HookConsumerWidget {
  const UpdateAvatarView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(meControllerProvider);

    // Chuyển avatarSeeds thành useState để có thể cập nhật lại UI khi bấm nút
    final avatarSeeds = useState<List<String>>([
      'seed1', 'seed2', 'seed3',
      'seed4', 'seed5', 'seed6',
      'seed7', 'seed8', 'seed9',
    ]);

    final selectedSeed = useState(state.avatarSeed);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        // H1: Outfit 700/24px, textPrimary500
        title: Text(
          'Avatar',
          style: AppTypography.h1.copyWith(color: AppColors.textPrimary500),
        ),
        centerTitle: true,
      ),
      extendBodyBehindAppBar: true,
      body: BackgroundGradient(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: AppSizes.s24),

              // ── Large preview avatar ──────────────────────────────────────
              // Figma: Ellipse 10 = 81×81px → radius ≈ 40 = r32 + r8
              Hero(
                tag: 'avatar_hero',
                child: CircleAvatar(
                  radius: AppSizes.r32 + AppSizes.r8,
                  backgroundImage: NetworkImage(
                    'https://api.dicebear.com/9.x/avataaars/png?seed=${selectedSeed.value}',
                  ),
                ),
              ),

              const SizedBox(height: AppSizes.s32),

              // ── Avatar grid (3×3) ─────────────────────────────────────────
              // Figma: each avatar 75×75, h-gap 44px, v-gap 24px, h-pad ~49px
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.s48, // ≈49px per Figma
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: AppSizes.s48 - AppSizes.s4, // 44px (Figma)
                    mainAxisSpacing: AppSizes.s24,                // 24px (Figma)
                  ),
                  itemCount: avatarSeeds.value.length, // Lấy length từ .value
                  itemBuilder: (context, index) {
                    final seed = avatarSeeds.value[index]; // Lấy seed từ .value
                    final isSelected = selectedSeed.value == seed;
                    return GestureDetector(
                      onTap: () => selectedSeed.value = seed,
                      child: AnimatedContainer(
                        duration: AppDurations.fast,
                        curve: Curves.easeInOut,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.surface600,
                          border: isSelected
                              ? Border.all(
                            color: AppColors.primary500,
                            width: 3.0,
                          )
                              : null,
                        ),
                        child: ClipOval(
                          child: Image.network(
                            'https://api.dicebear.com/9.x/avataaars/png?seed=$seed',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // ── "Change" refresh button ───────────────────────────────────
              // Figma: H3 Outfit 600/18px, textMuted500, arrow-refresh icon
              TextButton.icon(
                onPressed: () {
                  // Logic Random 9 cái seed mới
                  final random = Random();
                  const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';

                  // Tạo 9 chuỗi ngẫu nhiên độ dài 6 ký tự để làm seed mới
                  avatarSeeds.value = List.generate(9, (_) {
                    return String.fromCharCodes(
                      Iterable.generate(
                          6,
                              (_) => chars.codeUnitAt(random.nextInt(chars.length))
                      ),
                    );
                  });
                },
                icon: Icon(
                  Icons.refresh_rounded,
                  color: AppColors.textMuted500,
                  size: AppSizes.s24,
                ),
                label: Text(
                  'Change',
                  style: AppTypography.h3.copyWith(
                    color: AppColors.textMuted500,
                  ),
                ),
              ),

              const SizedBox(height: AppSizes.s8),

              // ── Save button ───────────────────────────────────────────────
              // Figma: 364×49px, primary500, border-radius 8, H2 white, save icon
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSizes.s24,
                  AppSizes.s8,
                  AppSizes.s24,
                  AppSizes.s16,
                ),
                child: ElevatedButton.icon(
                  onPressed: () {
                    ref
                        .read(meControllerProvider.notifier)
                        .updateAvatar(selectedSeed.value);
                    context.pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary500,
                    minimumSize: const Size(double.infinity, AppSizes.s48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSizes.r8),
                    ),
                    elevation: 1,
                    shadowColor: AppColors.textBody900.withOpacity(0.26),
                  ),
                  // save-01 icon (Figma: left of "Save" label)
                  icon: const Icon(Icons.save_rounded, color: AppColors.surface50),
                  label: Text(
                    'Save',
                    style: AppTypography.h2.copyWith(color: AppColors.surface50),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}