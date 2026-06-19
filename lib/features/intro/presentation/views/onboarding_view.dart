import 'package:flutter/material.dart';
import 'package:vibeu_fe/config/UI/design_system.dart';
import '../widgets/onboarding_page.dart';
import '../widgets/pagination_dots.dart';
import '../widgets/onboarding_bottom_bar.dart';

class OnboardingData {
  final String title;
  final String description;
  final String topImagePath;
  final String bottomImagePath;

  const OnboardingData({
    required this.title,
    required this.description,
    required this.topImagePath,
    required this.bottomImagePath,
  });
}

const List<OnboardingData> _pages = [
  OnboardingData(
    title: 'SWIPING',
    description:
        'Swipe right to like someone, or swipe left to pass. It\'s that simple to find your next connection!',
    topImagePath: 'assets/images/swiping_onboarding_1.webp',
    bottomImagePath: 'assets/images/swiping2_onboarding_1.webp',
  ),
  OnboardingData(
    title: 'MATCHING',
    description:
        'When the feeling is mutual, a conversation starts. Break the ice and chat with your new connections.',
    topImagePath: 'assets/images/matching_onboarding_2.webp',
    bottomImagePath: 'assets/images/matching_onboarding_2.webp',
  ),
  OnboardingData(
    title: 'CONNECTING',
    description:
        'Discover people who share your passions and vibe. Meet up in the real world to build lasting friendships and community.',
    topImagePath: 'assets/images/connecting_onboarding_3.webp',
    bottomImagePath: 'assets/images/connecting2_onboarding_3.webp',
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
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      _navigateToAuth();
    }
  }

  void _navigateToAuth() {
    // TODO: Replace with actual auth route when partner's feature is ready
    // Navigator.of(context).pushReplacementNamed('/login');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Navigating to Login...')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLastPage = _currentPage == _pages.length - 1;

    return Scaffold(
      backgroundColor: AppColors.surface50,
      body: Column(
        children: [
          // PageView takes most of the screen
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

          // Bottom bar: Skip + Next/GetStarted
          OnboardingBottomBar(
            isLastPage: isLastPage,
            onSkip: _navigateToAuth,
            onNext: _goToNext,
          ),
        ],
      ),
    );
  }
}
