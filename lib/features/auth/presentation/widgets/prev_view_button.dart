import 'package:flutter/material.dart';

class PrevViewButton extends StatelessWidget {
  final VoidCallback onPressed;
  const PrevViewButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return BackButton(
      style: ButtonStyle(
        iconSize: .all(40),
      ),
      onPressed: onPressed,
    );
  }
}
