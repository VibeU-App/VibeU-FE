import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vibeu_fe/config/UI/design_system.dart';

/// Giới hạn ký tự tối đa cho Nickname (theo Figma: "0/15")
const int _kNicknameMaxLength = 15;

/// Mở bottom sheet chỉnh Nickname.
/// [initialValue] là giá trị hiện tại.
/// Trả về [String] mới nếu user bấm Save, null nếu cancel.
Future<String?> showNicknameBottomSheet(
  BuildContext context, {
  required String initialValue,
}) {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    // Keyboard đẩy bottom sheet lên
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _NicknameBottomSheet(initialValue: initialValue),
  );
}

class _NicknameBottomSheet extends StatefulWidget {
  final String initialValue;
  const _NicknameBottomSheet({required this.initialValue});

  @override
  State<_NicknameBottomSheet> createState() => _NicknameBottomSheetState();
}

class _NicknameBottomSheetState extends State<_NicknameBottomSheet> {
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
    // viewInsets.bottom = chiều cao keyboard khi mở
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
      // Padding bottom = keyboard height → không bị che
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

          // ── Title row: "Nickname" + Save ─────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.s24,
              vertical: AppSizes.s16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Spacer trái để center title (bằng width nút Save)
                const SizedBox(width: 40),
                Text(
                  'Nickname',
                  style: AppTypography.h2.copyWith(color: AppColors.textBody500),
                ),
                // Nút Save: xám khi rỗng, đỏ khi có ký tự
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

          // ── Input field ─────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.s24),
            child: Container(
              height: 55,
              decoration: BoxDecoration(
                color: AppColors.surface600, // #E8E8E8
                borderRadius: BorderRadius.circular(AppSizes.r12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.s16),
              child: TextField(
                controller: _controller,
                autofocus: true,
                maxLength: _kNicknameMaxLength,
                // Ẩn counter mặc định của TextField (ta tự vẽ)
                buildCounter: (_, {required currentLength, required isFocused, maxLength}) => null,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(_kNicknameMaxLength),
                ],
                style: AppTypography.bodyLead.copyWith(color: AppColors.textBody500),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'You can change your nickname once a week',
                  hintStyle: AppTypography.caption.copyWith(
                    color: AppColors.textMuted500,
                  ),
                ),
              ),
            ),
          ),

          // ── Character counter: 0/15 ──────────────────────────────
          Padding(
            padding: const EdgeInsets.only(
              right: AppSizes.s24,
              top: AppSizes.s8,
              bottom: AppSizes.s16,
            ),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                '${_controller.text.length}/$_kNicknameMaxLength',
                style: AppTypography.caption.copyWith(
                  color: AppColors.textMuted500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
