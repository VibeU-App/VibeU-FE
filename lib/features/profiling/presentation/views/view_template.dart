import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:vibeu_fe/config/UI/design_system.dart';
import 'package:vibeu_fe/features/auth/presentation/widgets/prev_view_button.dart';
import 'package:vibeu_fe/features/auth/presentation/widgets/vibe_primary_button.dart';

import '../widgets/pagination_bars.dart';

typedef PageEvent = void Function(PageController);

class ViewTemplate extends HookConsumerWidget {
  const ViewTemplate({
    super.key,
    this.buttonIcon,
    required this.buttonText,
    required this.showBackgroundImage,
    required this.showPaginationBars,
    required this.firstPageBackBtn,
    required this.backBtn,
    required this.lastPageForwardBtn,
    required this.forwardBtn,
    required this.pageCount,
    required this.childrenDelegate,
  });

  final Widget? buttonIcon;
  final String buttonText;
  final int pageCount;
  final SliverChildDelegate childrenDelegate;
  final bool showBackgroundImage;
  final bool showPaginationBars;
  final PageEvent firstPageBackBtn;
  final PageEvent backBtn;
  final PageEvent lastPageForwardBtn;
  final PageEvent forwardBtn;

  static const backgroundImageRatio = 0.25;
  static const paginationBarsWidthRatio = 0.5;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screen = MediaQuery.sizeOf(context);
    final pageController = usePageController();
    final currentPage = useState(0);

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
        body: SafeArea(
          child: Stack(
            children: [
              if (showBackgroundImage)
              Center(
                child: Opacity(
                  opacity: 0.5,
                  child: Image(
                    image: const AssetImage(AppAssets.vibeU),
                    height: screen.height * backgroundImageRatio,
                  ),
                )
              ),

              Column(
                spacing: AppSizes.s16,
                crossAxisAlignment: .start,
                children: [
                  PrevViewButton(
                    onPressed: () {
                      if (currentPage.value == 0) {
                        firstPageBackBtn(pageController);
                      } else {
                        backBtn(pageController);
                      }
                    }
                  ),
                  if (showPaginationBars)
                  Align(
                    alignment: .center,
                    child: SizedBox(
                      width: screen.width * paginationBarsWidthRatio,
                      child: PaginationBars(
                        totalPage: pageCount,
                        page: currentPage.value,
                      )
                    )
                  ),
                  Expanded(
                    child: PageView.custom(
                      controller: pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      onPageChanged: (index) { currentPage.value = index; },
                      childrenDelegate: childrenDelegate,
                    )
                  ),
                  const SizedBox(height: AppSizes.s48)
                ]
              )
            ]
          )
        ),
        bottomNavigationBar: VibePrimaryButton(
          text: buttonText,
          icon: buttonIcon,
          onPressed: () async {
            if (currentPage.value == pageCount - 1) {
              lastPageForwardBtn(pageController);
            } else {
              forwardBtn(pageController);
            }
          }
        ),
      )
    );
  }
}
