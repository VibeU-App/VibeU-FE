import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vibeu_fe/config/UI/design_system.dart';
import 'package:vibeu_fe/features/auth/presentation/widgets/background_gradient.dart';
import '../widgets/setting_item_tile.dart';
import '../controllers/me_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_hicons/flutter_hicons.dart';
class SettingsView extends HookConsumerWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(meControllerProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Settings',
          style: GoogleFonts.outfit(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary500,
          ),
        ),
        centerTitle: true,
      ),
      extendBodyBehindAppBar: true,
      body: BackgroundGradient(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.s24),
            children: [
              const SizedBox(height: AppSizes.s8),
              // Profile Row — leading SizedBox(s32) đồng bộ với SettingItemTile
              InkWell(
                onTap: () => context.push('/me/edit-profile'),
                borderRadius: BorderRadius.circular(AppSizes.r8),
                child: Padding(
                  // padding đồng nhất với SettingItemTile
                  padding: const EdgeInsets.symmetric(vertical: AppSizes.s16),
                  child: Row(
                    children: [
                      // Avatar nằm trong SizedBox(s32) để text thẳng hàng
                      SizedBox(
                        width: AppSizes.s32,
                        height: AppSizes.s32,
                        child: CircleAvatar(
                          radius: AppSizes.r32 ,
                          backgroundImage: NetworkImage(
                            'https://api.dicebear.com/9.x/avataaars/png?seed=${state.avatarSeed}',
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSizes.s16),
                      Expanded(
                        child: Text(
                          'Profile',
                          style: AppTypography.bodyLead,
                        ),
                      ),
                      const Icon(
                        Icons.chevron_right,
                        color: AppColors.surface800,
                      ),
                    ],
                  ),
                ),
              ),
              SettingItemTile(
                icon: Hicons.notification1LightOutline,
                title: 'Notifications',
                onTap: () {},
              ),
              SettingItemTile(
                icon: Icons.translate,
                title: 'Languages',
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
