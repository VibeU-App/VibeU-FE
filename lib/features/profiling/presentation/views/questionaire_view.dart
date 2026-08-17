import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../controllers/profiling_controller.dart';

import 'view_template.dart';
import '../widgets/question_page.dart';

// for the sole purpose of being a dummy model
import '../controllers/question_view_model.dart';

class QuestionaireView extends ConsumerWidget {
  const QuestionaireView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ViewTemplate(
      pageCount: 4, //
      childrenDelegate: SliverChildBuilderDelegate(
        (_, index) {
          final question = Question(
            id: "q$index",
            title: "question$index",
            question: "description$index",
            answers: List.generate(4, (i) {
              return Answer(id: "q${index}_$i", answer: "answer_$i");
            }, growable: false),
          );
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
