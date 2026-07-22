import 'package:flutter/material.dart';

abstract class FlowController extends ChangeNotifier {
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final PageController _pageController = PageController();
  final defaultDuration = Duration(milliseconds: 400);
  final defaultCurve = Curves.easeInOut;

  PageController get page => _pageController;
  
  void nextPage({Duration? duration, Curve? curve}) {
    _pageController.nextPage(
      duration: duration ?? defaultDuration,
      curve: curve ?? defaultCurve,
    );
  }

  void previousPage({Duration? duration, Curve? curve}) {
    _pageController.previousPage(
      duration: duration ?? defaultDuration,
      curve: curve ?? defaultCurve,
    );
  }
}
