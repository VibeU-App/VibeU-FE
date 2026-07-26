import 'dart:async';

import 'package:flutter/material.dart';

import 'package:vibeu_fe/config/UI/design_system.dart';

class OtpBox extends StatelessWidget {
  final String? num;
  final bool focused;
  
  const OtpBox({
    super.key,
    required this.num,
    required this.focused,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.0,
      height: 40.0,
      alignment: .center,
      decoration: BoxDecoration(
        borderRadius: .circular(AppSizes.r8),
        border: .all(
          color: focused ? AppColors.primary500 : AppColors.surface600
        ),
      ),
      child: RepaintBoundary(child: focused ? const _AnimatedCursor() :
        (num != null ? Text(num!, style: AppTypography.button) : null),
      )
    );
  }
}

class _AnimatedCursor extends StatefulWidget {
  const _AnimatedCursor();
  
  @override
  State<_AnimatedCursor> createState() => _AnimatedCursorState();
}

class _AnimatedCursorState extends State<_AnimatedCursor> {
  late bool _showCursor;
  late Timer? _timer;

  @override
  void initState() {
    super.initState();
    _showCursor = true;
    _timer = Timer.periodic(
      const Duration(milliseconds: 500),
      (_) { 
        setState(() {
          if (!mounted) return;
          _showCursor = !_showCursor;
        });
      }
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: _showCursor ? 1 : 0,
      child: Container(height: 35, width: 2, color: Colors.black),
    );
  }
}
