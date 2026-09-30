import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vibeu_fe/config/UI/design_system.dart';
import 'package:vibeu_fe/features/Me/presentation/controllers/me_controller.dart';
import 'package:vibeu_fe/features/posts/presentation/views/create_post_view.dart';

class CreatePostInputArea extends HookConsumerWidget {
  const CreatePostInputArea({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meState = ref.watch(meControllerProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage(
                  'https://api.dicebear.com/9.x/avataaars/png?seed=${meState.avatarSeed}',
                ),
                backgroundColor: AppColors.background300,
              ),
              const SizedBox(width: 12),
              Text(
                meState.nickname.isNotEmpty ? meState.nickname : 'abc',
                style: AppTypography.caption.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: TextField(
              autofocus: true, // This automatically opens the keyboard to fill the empty space
              maxLines: null,
              onChanged: (val) {
                ref.read(postContentProvider.notifier).updateContent(val);
              },
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              style: AppTypography.bodyStd.copyWith(color: AppColors.textPrimary900),
              decoration: InputDecoration(
                hintText: 'Share your status',
                hintStyle: AppTypography.caption.copyWith(
                  color: const Color(0xFF64748B), // Muted text color from design
                ),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
