import 'package:flutter/material.dart';

class PrevScreenButton extends StatelessWidget {
  const PrevScreenButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BackButton(
      style: ButtonStyle(
        iconSize: .all(40),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      }
    );
  }
}
