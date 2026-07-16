import 'package:flutter/material.dart';

class PrevViewButton extends StatelessWidget {
  final VoidCallback onPressed;
  const PrevViewButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: .zero,
      icon: Transform.translate(
        offset: const Offset(-6, 0),
        child: const Icon(Icons.arrow_back_rounded),
      ),
      iconSize: 40,
      style: IconButton.styleFrom(
        overlayColor: Colors.transparent,
      ),
      onPressed: onPressed,
    );
  }
}
