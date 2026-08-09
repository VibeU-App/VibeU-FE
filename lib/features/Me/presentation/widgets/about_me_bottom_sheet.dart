import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vibeu_fe/config/UI/design_system.dart';

const int _kAboutMeMaxLength = 120;

/// Mở bottom sheet chỉnh About me.
/// [initialValue] là giá trị hiện tại.
/// Trả về [String] mới nếu user bấm Save, null nếu cancel.
Future<String?> showAboutMeBottomSheet(
  BuildContext context, {
  required String initialValue,
}) {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _AboutMeBottomSheet(initialValue: initialValue),
  );
}

class _AboutMeBottomSheet extends StatefulWidget {
  final String initialValue;
  const _AboutMeBottomSheet({required this.initialValue});

  @override
  State<_AboutMeBottomSheet> createState() => _AboutMeBottomSheetState();
}

class _AboutMeBottomSheetState extends State<_AboutMeBottomSheet> {
  late final TextEditingController _controller;

  /// True khi có ít nhất 1 ký tự → nút Save đỏ
  bool get _canSave => _controller.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface50,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSizes.r12),
        ),
        border: Border(
          top: BorderSide(color: AppColors.surface700, width: 1),
          left: BorderSide(color: AppColors.surface700, width: 1),
          right: BorderSide(color: AppColors.surface700, width: 1),
        ),
      ),
      padding: EdgeInsets.only(bottom: keyboardHeight),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Drag handle ──────────────────────────────────────────
          const SizedBox(height: AppSizes.s16),
          Container(
            width: 60,
            height: 3,
            decoration: BoxDecoration(
              color: AppColors.surface600,
              borderRadius: BorderRadius.circular(AppSizes.r999),
            ),
          ),

          // ── Title row: "About me" + Save ─────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.s24,
              vertical: AppSizes.s16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 40), // Spacer left
                Text(
                  'About me',
                  style: AppTypography.h2.copyWith(color: AppColors.textBody500),
                ),
                GestureDetector(
                  onTap: _canSave
                      ? () => Navigator.of(context).pop(_controller.text.trim())
                      : null,
                  child: Text(
                    'Save',
                    style: AppTypography.h3.copyWith(
                      color: _canSave
                          ? AppColors.textPrimary500
                          : AppColors.textMuted500,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── Input field area ─────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.s24),
            child: Container(
              height: 140, // Height from Figma
              decoration: BoxDecoration(
                color: AppColors.surface600, // #E8E8E8
                borderRadius: BorderRadius.circular(AppSizes.r12),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(AppSizes.s16),
                    child: TextField(
                      controller: _controller,
                      autofocus: true,
                      maxLength: _kAboutMeMaxLength,
                      maxLines: null, // Allow multiline
                      keyboardType: TextInputType.multiline,
                      buildCounter: (
                        _, {
                        required currentLength,
                        required isFocused,
                        maxLength,
                      }) =>
                          null, // Hide default counter
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(_kAboutMeMaxLength),
                      ],
                      style: AppTypography.bodyLead.copyWith(
                        color: AppColors.textBody500,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        hintText: 'Tell everyone something about you!',
                        hintStyle: AppTypography.caption.copyWith(
                          color: AppColors.textMuted500,
                        ),
                      ),
                    ),
                  ),
                  
                  // ── Character counter: 0/120 ───────────────────────
                  Positioned(
                    bottom: AppSizes.s16,
                    right: AppSizes.s16,
                    child: Text(
                      '${_controller.text.length}/$_kAboutMeMaxLength',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textMuted500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: AppSizes.s24),
        ],
      ),
    );
  }
}
