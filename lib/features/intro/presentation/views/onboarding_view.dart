import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vibeu_fe/config/UI/design_system.dart';
import 'package:vibeu_fe/routing/routes.dart';
import '../widgets/onboarding_page.dart';
import '../widgets/onboarding_bottom_bar.dart';

class OnboardingData {
  final String title;
  final String description;
  final String imagePath;

  const OnboardingData({
    required this.title,
    required this.description,
    required this.imagePath,
  });
}

const List<OnboardingData> _pages = [
  OnboardingData(
    title: 'SWIPING',
    description:
        'Swipe right to like someone, or swipe left to pass. It\'s that simple to find your next connection!',
    imagePath: AppAssets.onboardingSwiping,
  ),
  OnboardingData(
    title: 'MATCHING',
    description:
        'When the feeling is mutual, a conversation starts. Break the ice and chat with your new connections.',
    imagePath: AppAssets.onboardingMatching,
  ),
  OnboardingData(
    title: 'CONNECTING',
    description:
        'Discover people who share your passions and vibe. Meet up in the real world to build lasting friendships and community.',
    imagePath: AppAssets.onboardingConnecting,
  ),
];

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() => _currentPage = index);
  }

  void _goToNext() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: AppDurations.medium,
        curve: Curves.easeInOut,
      );
    } else {
      _navigateToAuth();
    }
  }

  void _navigateToAuth() {
    context.go(Routes.login);
  }

  @override
  Widget build(BuildContext context) {
    final isLastPage = _currentPage == _pages.length - 1;

    return Scaffold(
      backgroundColor: AppColors.surface50,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                physics: const BouncingScrollPhysics(),
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return OnboardingPage(
                    data: _pages[index],
                    currentPage: _currentPage,
                    totalPages: _pages.length,
                  );
                },
              ),
            ),
            OnboardingBottomBar(
              isLastPage: isLastPage,
              onSkip: _navigateToAuth,
              onNext: _goToNext,
            ),
          ],
        ),
      ),
    );
  }
}
