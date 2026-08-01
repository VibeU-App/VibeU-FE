import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:vibeu_fe/config/UI/design_system.dart';
import 'package:vibeu_fe/features/auth/presentation/widgets/vibe_text_span.dart';

import '../widgets/header.dart';
import '../widgets/tag_container.dart';
import '../widgets/tag_list.dart';
import '../widgets/tag_template.dart';

const categories = [
  ('Personality', ['Eccentric', 'Extroverted', 'Introverted', 'Rational']),
  ('Communication Style', ['Direct', 'Indirect', 'Concise', 'Verbose']),
  ('Gender', ['Gay']),
];


class HobbyPage extends HookConsumerWidget {
  const HobbyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tagContainer = useMemoized(() => TagContainerController());
    final tagList = useMemoized(() => TagListController(categories: categories));

    return Column(
      children: [
        const Header(
          title: 'Your Hobby',
          subTitle: 'We match you base on your hobbies',
        ),

        const SizedBox(height: AppSizes.s32),

        Expanded(
          child: TagContainer(
            controller: tagContainer,
            labelBuilder: (tag) {
              return VibeTextSpan(
                defaultStyle: AppTypography.h3,
                inlineActionStyle: TextStyle(color: AppColors.primary500),
              )
              ..text('Your tags: ')
              ..link('$tag')
              ..text('/10 selected');
            },
            tagBuilder: (label) {
              return TagTemplate(
                label: label,
                removeable: true,
                enableToggle: false,
                onRemoval: (tag) {
                  tagContainer.remove(tag);
                  tagList.disable(tag);
                }
              );
            },
          ),
        ),
        
        const SizedBox(height: AppSizes.s48),

        Expanded(
          child: TagList(
            controller: tagList,
            onTagEnabled: (tag) { tagContainer.add(tag); },
            onTagDisabled: (tag) { tagContainer.remove(tag); },
          )
        ),
      ]
    );
  }
}
