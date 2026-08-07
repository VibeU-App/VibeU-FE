import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'package:vibeu_fe/config/UI/design_system.dart';
import 'package:vibeu_fe/routing/routes.dart';

import '../controllers/profiling_controller.dart';
import 'view_template.dart';

import '../widgets/avatar_page.dart';
import '../widgets/nickname_page.dart';
import '../widgets/birthday_page.dart';
import '../widgets/hobby_page.dart';

class ProfilingView extends HookConsumerWidget {
  const ProfilingView({ super.key, });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pages = useMemoized(() => [
      const AvatarPage(),
      const NicknamePage(),
      const BirthdayPage(),
      const HobbyPage(),
    ]);
    ref.watch(profilingControllerProvider);

    return ViewTemplate(
      pageCount: pages.length,
      childrenDelegate: SliverChildListDelegate(pages.map((p) {
        return ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            scrollbars: false,
          ),
          child: SingleChildScrollView(
            child: p
          )
        );
      }).toList()),
      showPaginationBars: true,
      showBackgroundImage: false,

      firstPageBackBtn: (_) {},
      backBtn: (pageController) {
        pageController.previousPage(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut
        );
      },

      lastPageForwardBtn: (_) {
        context.push(Routes.questionnaire);
      },
      forwardBtn: (pageController) {
        pageController.nextPage(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      },
      buttonText: 'Continue',
      buttonIcon: const Icon(
        AntDesign.arrowright,
        size: AppSizes.s32,
        color: AppColors.surface500,
      ),
    );
  }
}
