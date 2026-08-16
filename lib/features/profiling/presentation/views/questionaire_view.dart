import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:vibeu_fe/config/questionnaire.dart';

import '../controllers/profiling_controller.dart';

import 'view_template.dart';
import '../widgets/question_page.dart';

class QuestionaireView extends HookConsumerWidget {
  const QuestionaireView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questionnaire = useMemoized(() => Questionnaire.all);

    return ViewTemplate(
      pageCount: questionnaire.length,
      childrenDelegate: SliverChildBuilderDelegate(
        (_, index) {
          final question = questionnaire[index]();
          final currentAnswer = ref.watch(personalitySetupProvider.select((state) {
            return state.answers[question.id];
          }));
          return QuestionPage(
            data: question,
            selected: question.answers.indexWhere((a) => a.id == currentAnswer),
            onSelected: (id) {
              ref.read(
                personalitySetupProvider.notifier
              ).setAnswer(question.id, id);
            }
          );
        }
      ),
      showPaginationBars: false,
      showBackgroundImage: true,

      firstPageBackBtn: (_) {
        context.pop();
      },
      backBtn: (pageController) {
        pageController.previousPage(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut
        );
      },

      lastPageForwardBtn: (_) {
        ref.read(personalitySetupProvider.notifier).finalize();
      },
      forwardBtn: (pageController) {
        pageController.nextPage(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut
        );
      },
      buttonText: 'Next',
    );
  }
}
