import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:vibeu_fe/config/UI/design_system.dart';
import 'package:vibeu_fe/features/auth/presentation/widgets/vibe_text_span.dart';
import 'package:vibeu_fe/features/profiling/presentation/controllers/profiling_controller.dart';

import '../widgets/header.dart';
import '../widgets/tag_container.dart';
import '../widgets/tag_list.dart';
import '../widgets/tag_template.dart';

const categories = [
  ('Personality', ['Eccentric', 'Extroverted', 'Introverted', 'Rational']),
  ('Communication Style', ['Direct', 'Indirect', 'Concise', 'Verbose']),
];


class HobbyPage extends HookConsumerWidget {
  const HobbyPage({super.key});

  static const tagContainerHeightRatio = 0.11;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screen = MediaQuery.sizeOf(context);
    final tagContainer = useMemoized(() => TagContainerController(
      tags: ref.read(profilingControllerProvider.notifier).getTags() ?? []
    ));
    final tagList = useMemoized(() => TagListController(
      categories: categories,
      selectedTags: tagContainer.tags,
    ));

    return Column(
      children: [
        const Header(
          title: 'Your Hobby',
          subTitle: 'We match you base on your hobbies',
        ),

        const SizedBox(height: AppSizes.s32),
        
        Align(
          alignment: .centerLeft,
          child: ListenableBuilder(
            listenable: tagContainer,
            builder: (_, _) {
              return VibeTextSpan(
                defaultStyle: AppTypography.h3,
                inlineActionStyle: TextStyle(color: AppColors.primary500),
              )
              ..text('Your tags: ')
              ..link('${tagContainer.tags.length}')
              ..text('/10 selected');
            }
          )
        ),

        SizedBox(
          height: screen.height * tagContainerHeightRatio,
          child: TagContainer(
            controller: tagContainer,
            tagBuilder: (label) {
              return TagTemplate(
                label: label,
                removeable: true,
                enableToggle: false,
                onRemoval: (tag) {
                  tagContainer.remove(tag);
                  tagList.disable(tag);
                  _updateTags(ref, tagContainer);
                },
              );
            },
          )
        ),
        
        const SizedBox(height: AppSizes.s48),

        TagList(
          controller: tagList,
          onTagEnabled: (tag) {
            tagContainer.add(tag);
            _updateTags(ref, tagContainer);
          },
          onTagDisabled: (tag) {
            tagContainer.remove(tag);
            _updateTags(ref, tagContainer);
          },
        )
      ]
    );
  }

  void _updateTags(WidgetRef ref, TagContainerController container) {
    ref.read(profilingControllerProvider.notifier).setTags(container.tags);
  }
}
