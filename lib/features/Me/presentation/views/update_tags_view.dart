import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vibeu_fe/config/UI/design_system.dart';
import 'package:vibeu_fe/features/auth/presentation/widgets/background_gradient.dart';
import 'package:vibeu_fe/features/Me/presentation/controllers/me_controller.dart';

import 'package:vibeu_fe/features/Me/presentation/widgets/bouncy_button.dart';

class UpdateTagsView extends HookConsumerWidget {
  const UpdateTagsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Current selected tags state (initialize from meController state)
    final initialTags = ref.read(meControllerProvider).tags.map((t) => t.label).toList();
    final selectedTags = useState<List<String>>(initialTags);

    final categories = [
      'Personality',
      'Communication Style',
      'Sport',
      'Pet',
      'Food',
    ];
    final selectedCategory = useState('Personality');

    // Hardcoded mock data for tags per category
    final tagsMap = {
      'Personality': ['Eccentric', 'Extroverted', 'Introverted', 'Rational', 'Adventurous'],
      'Communication Style': ['Direct', 'Humorous', 'Empathetic', 'Quiet'],
      'Sport': ['Soccer', 'Tennis', 'Swimming', 'Gym'],
      'Pet': ['Dog', 'Cat', 'Bird', 'Fish'],
      'Food': ['Vegan', 'Seafood', 'Spicy', 'Sweet'],
    };

    // Helper to get count of selected tags in a specific category
    int getSelectedCount(String category) {
      final catTags = tagsMap[category] ?? [];
      return selectedTags.value.where((t) => catTags.contains(t)).length;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textBody900),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Update Tags',
          style: AppTypography.h2.copyWith(color: AppColors.textPrimary500),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppSizes.s24),
            child: Center(
              child: BouncyButton(
                onPressed: () {
                  final newTags = selectedTags.value
                      .map((label) => VibeTag(label: label, type: TagType.other))
                      .toList();
                  ref.read(meControllerProvider.notifier).updateTags(newTags);
                  context.pop();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: AppSizes.s16, vertical: AppSizes.s4),
                  decoration: BoxDecoration(
                    color: AppColors.primary500,
                    borderRadius: BorderRadius.circular(AppSizes.r999),
                  ),
                  child: Text(
                    'Done',
                    style: AppTypography.caption.copyWith(color: AppColors.surface50),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: BackgroundGradient(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSizes.s16),
              // Chips of selected tags at the top
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.s24),
                child: Wrap(
                  spacing: AppSizes.s16,
                  runSpacing: AppSizes.s16,
                  children: selectedTags.value
                      .map((tag) => _TopSelectedTagChip(
                            label: tag,
                            onDeleted: () {
                              selectedTags.value =
                                  selectedTags.value.where((t) => t != tag).toList();
                            },
                          ))
                      .toList(),
                ),
              ),

              const Spacer(),

              // Bottom Sheet Part
              Container(
                height: 454, // From Figma
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColors.surface600,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(AppSizes.r12)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppSizes.s16),
                    // Category Tab Bar
                    SizedBox(
                      height: 40,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: AppSizes.s16),
                        itemCount: categories.length,
                        separatorBuilder: (context, index) => const SizedBox(width: AppSizes.s24 - AppSizes.s4),
                        itemBuilder: (context, index) {
                          final cat = categories[index];
                          final isSelected = selectedCategory.value == cat;
                          final count = getSelectedCount(cat);

                          return BouncyButton(
                            onPressed: () => selectedCategory.value = cat,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Center(
                                  child: Text(
                                    cat,
                                    style: AppTypography.button.copyWith(
                                      color: isSelected
                                          ? AppColors.primary500
                                          : AppColors.textBody900,
                                    ),
                                  ),
                                ),
                                if (count > 0)
                                  Container(
                                    margin: const EdgeInsets.only(left: 4, top: 4),
                                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary100,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      count.toString(),
                                      style: AppTypography.overline.copyWith(
                                        color: AppColors.textPrimary500,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    
                    const SizedBox(height: AppSizes.s24),

                    // Tags List for selection
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: AppSizes.s16),
                        child: Wrap(
                          spacing: AppSizes.s8,
                          runSpacing: AppSizes.s16,
                          children: (tagsMap[selectedCategory.value] ?? []).map((tag) {
                            final isSelected = selectedTags.value.contains(tag);
                            return BouncyButton(
                              onPressed: () {
                                if (isSelected) {
                                  selectedTags.value =
                                      selectedTags.value.where((t) => t != tag).toList();
                                } else {
                                  selectedTags.value = [...selectedTags.value, tag];
                                }
                              },
                              child: AnimatedContainer(
                                duration: AppDurations.quick,
                                curve: Curves.easeInOut,
                                padding: const EdgeInsets.symmetric(horizontal: AppSizes.s16 - AppSizes.s4, vertical: AppSizes.s8),
                                decoration: BoxDecoration(
                                  color: isSelected ? AppColors.accent500 : AppColors.surface600,
                                  borderRadius: BorderRadius.circular(AppSizes.r32),
                                ),
                                child: Text(
                                  tag,
                                  style: AppTypography.caption.copyWith(
                                    color: isSelected ? AppColors.surface50 : AppColors.textBody900,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopSelectedTagChip extends StatelessWidget {
  final String label;
  final VoidCallback onDeleted;

  const _TopSelectedTagChip({
    required this.label,
    required this.onDeleted,
  });

  @override
  Widget build(BuildContext context) {
    return BouncyButton(
      onPressed: onDeleted,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.s16 - AppSizes.s4, vertical: AppSizes.s8),
        decoration: BoxDecoration(
          color: AppColors.surface600,
          borderRadius: BorderRadius.circular(AppSizes.r32),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: AppTypography.caption.copyWith(color: AppColors.textBody900),
            ),
            const SizedBox(width: AppSizes.s8),
            const Icon(
              Icons.close,
              size: 14,
              color: AppColors.textBody900,
            ),
          ],
        ),
      ),
    );
  }
}
