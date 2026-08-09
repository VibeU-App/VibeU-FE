import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vibeu_fe/config/UI/design_system.dart';
import 'package:vibeu_fe/features/auth/presentation/widgets/background_gradient.dart';
import '../widgets/nickname_bottom_sheet.dart';
import '../widgets/dob_bottom_sheet.dart';
import '../widgets/about_me_bottom_sheet.dart';
import '../controllers/me_controller.dart';

class EditProfileView extends HookConsumerWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(meControllerProvider);

    // Hooks to track changes for the Save button color
    final nicknameController = useTextEditingController(text: state.nickname);
    final bioController = useTextEditingController(text: state.bio);

    // DOB state (Simplified for UI demonstration)
    final dobText = state.dob != null
        ? '${state.dob!.day.toString().padLeft(2, '0')}-${state.dob!.month.toString().padLeft(2, '0')}-${state.dob!.year}'
        : '07-07-2006';

    // Listen to changes to update UI (Save button color)
    final hasChanges = useState(false);

    useEffect(() {
      void listener() {
        hasChanges.value = nicknameController.text != state.nickname ||
            bioController.text != state.bio;
      }

      nicknameController.addListener(listener);
      bioController.addListener(listener);
      return () {
        nicknameController.removeListener(listener);
        bioController.removeListener(listener);
      };
    }, [nicknameController, bioController, state]);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Profile',
          style: AppTypography.h1.copyWith(color: AppColors.textPrimary500),
        ),
        centerTitle: true,
      ),
      extendBodyBehindAppBar: true,
      body: BackgroundGradient(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.s24),
            children: [
              _buildEditItem(
                label: 'Avatar',
                trailing: Hero(
                  tag: 'avatar_hero',
                  child: CircleAvatar(
                    radius: AppSizes.r20,
                    backgroundImage: NetworkImage(
                      'https://api.dicebear.com/9.x/avataaars/png?seed=${state.avatarSeed}',
                    ),
                  ),
                ),
                onTap: () => context.push('/me/edit-profile/update-avatar'),
              ),
              _buildEditItem(
                label: 'Nickname',
                value: nicknameController.text,
                onTap: () async {
                  final result = await showNicknameBottomSheet(
                    context,
                    initialValue: nicknameController.text,
                  );
                  if (result != null) {
                    nicknameController.text = result;
                  }
                },
              ),
              _buildEditItem(
                label: 'Sex',
                value: 'Male',
                subLabel: 'You cannot change this',
                onTap: null,
              ),
              _buildEditItem(
                label: 'Date of Birth',
                value: dobText,
                onTap: () async {
                  final result = await showDobBottomSheet(
                    context,
                    initialDate: state.dob,
                  );
                  if (result != null) {
                    ref.read(meControllerProvider.notifier).updateDob(result);
                  }
                },
              ),
              _buildEditItem(
                label: 'Vibe testing',
                value: 'Lotus',
                onTap: null,
              ),
              _buildEditItem(
                label: 'Hobby',
                onTap: () => context.push('/me/edit-profile/update-tags'),
              ),
              _buildEditItem(
                label: 'About me',
                onTap: () async {
                  final result = await showAboutMeBottomSheet(
                    context,
                    initialValue: bioController.text,
                  );
                  if (result != null) {
                    bioController.text = result;
                    ref.read(meControllerProvider.notifier).updateBio(result);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEditItem({
    required String label,
    String? value,
    String? subLabel,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSizes.s16),
        // Row chính: center theo chiều cao toàn bộ row (kể cả subLabel)
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left: label + subLabel trong cùng 1 Column
            // → Row tính chiều cao đầy đủ (label + subLabel) rồi center value vào giữa
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    style: AppTypography.bodyLead.copyWith(
                      color: AppColors.textBody500,
                    ),
                  ),
                  if (subLabel != null)
                    Text(
                      subLabel,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textMuted500,
                      ),
                    ),
                ],
              ),
            ),
            // Right: value text, trailing, chevron — tất cả center theo chiều cao Row
            if (value != null)
              Text(
                value,
                style: AppTypography.bodyStd.copyWith(
                  color: AppColors.textMuted500,
                ),
              ),
            if (trailing != null) ...[
              const SizedBox(width: AppSizes.s8),
              trailing,
            ],

            // --- KHÚC NÀY ĐÃ ĐƯỢC SỬA LẠI ĐỂ CANH LỀ CHUẨN ---
            const SizedBox(width: AppSizes.s8),
            if (onTap != null)
              const Icon(
                Icons.chevron_right,
                color: AppColors.surface800,
              )
            else
              const SizedBox(width: 24), // Bù đúng 24px của cái icon bị thiếu
          ],
        ),
      ),
    );
  }

}