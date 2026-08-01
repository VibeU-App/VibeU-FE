import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'package:vibeu_fe/config/UI/design_system.dart';
import 'package:vibeu_fe/features/auth/presentation/widgets/prev_view_button.dart';
import 'package:vibeu_fe/features/auth/presentation/widgets/vibe_primary_button.dart';

import '../widgets/pagination_bars.dart';
import '../widgets/avatar_page.dart';
import '../widgets/nickname_page.dart';
import '../widgets/birthday_page.dart';
import '../widgets/hobby_page.dart';

class ProfilingView extends HookWidget {
  const ProfilingView({ super.key, });

  static const paginationBarsWidthRatio = 0.5;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final page = usePageController();
    final pageIndex = useState(0);
    final pages = useState([
      const AvatarPage(),
      const NicknamePage(),
      const BirthdayPage(),
      const HobbyPage(),
    ]);

    return Container(
      padding: const .fromLTRB(24, 24, 24, 56),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            AppColors.surface500,
            AppColors.background500,
          ],
          begin: .topCenter,
          end: .bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Column(
            spacing: AppSizes.s16,
            crossAxisAlignment: .start,
            children: [
              PrevViewButton(
                onPressed: () {
                  page.previousPage(
                    duration: const Duration(milliseconds: 400), 
                    curve: Curves.easeInOut
                  );
                }
              ),
              Align(
                alignment: .center,
                child: SizedBox(
                  width: screenWidth * paginationBarsWidthRatio,
                  child: PaginationBars(
                      totalPage: pages.value.length,
                      page: pageIndex.value
                  )
                )
              ),
              Expanded(
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: page,
                  onPageChanged: (index) { pageIndex.value = index; },
                  children: pages.value,
                ),
              ),
              VibePrimaryButton(
                text: "Continue",
                icon: const Icon(
                  AntDesign.arrowright,
                  size: AppSizes.s32,
                  color: AppColors.surface500,
                ),
                onPressed: () async {
                  page.nextPage(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut
                  );
                }
              )
            ],
          ),
        ),
      )
    );
  }
}
