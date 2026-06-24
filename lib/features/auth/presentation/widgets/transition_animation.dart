import 'package:flutter/material.dart';

Route<void> createRoute(
  Widget widget,
) {
  return PageRouteBuilder(
    pageBuilder: (_, _, _) => widget,
    transitionsBuilder: (_, animation, _, child) {
      return SlideTransition(
        position: animation.drive(
          Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: const Offset(0.0, 0.0),
          ).chain(CurveTween(curve: Curves.ease)),
        ),
        child: child,
      );
    }

  );
}
