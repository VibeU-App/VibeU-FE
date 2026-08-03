import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:vibeu_fe/config/UI/design_system.dart';
import 'package:vibeu_fe/config/questionnaire.dart';

import '../widgets/answer_button.dart';

class QuestionPage extends HookWidget {
  const QuestionPage({
    super.key,
    required this.data,
    required this.selected,
    required this.onSelected,
  });

  final Question data;
  final int selected;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState(selected);
    final answers = data.answers;
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: _QuestionContainer(
            title: data.title,
            content: data.question,
          ),
        ),
        SliverList.builder(
          itemCount: data.answers.length,
          itemBuilder: (_, index) {
            return AnswerButton(
              index: index,
              answer: answers[index].answer,
              selected: selectedIndex.value == index,
              onPressed: () {
                selectedIndex.value = index;
                onSelected(answers[index].id);
              }
            );
          }
        )
      ]
    );
  }
}

class _QuestionContainer extends SliverPersistentHeaderDelegate {
  const _QuestionContainer({
    required this.title,
    required this.content,
  });

  final String title;
  final String content;
  // final Widget image;

  @override
  double get minExtent => 0;

  @override
  double get maxExtent => 200;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: const .all(.circular(AppSizes.r12)),
          border: Border.all(color: AppColors.surface700),
          boxShadow: [AppShadows.low],
          color: AppColors.surface500,
        ),
        child: ListView(
          padding: .symmetric(vertical: AppSizes.r12, horizontal: AppSizes.s16),
          children: [
            Text(
              title,
              style: AppTypography.h2,
            ),

            Text(
              content,
              style: AppTypography.bodyStd,
            )
          ]
        )
      ),
    );
  }
}
