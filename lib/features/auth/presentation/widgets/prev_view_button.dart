import 'package:flutter/material.dart';

class PrevViewButton extends StatelessWidget {
  const PrevViewButton({super.key});

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
