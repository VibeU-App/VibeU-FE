import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class VibeTextSpan extends StatelessWidget {
  final TextStyle defaultStyle;
  final TextStyle inlineActionStyle;
  final List<({String text, VoidCallback? onTap})> textSpan;

  const VibeTextSpan({
    super.key,
    required this.defaultStyle,
    required this.inlineActionStyle,
    required this.textSpan,
  });

  @override
    Widget build(BuildContext context) {
      List<TextSpan> list = [];
      for (var span in textSpan) {
        list.add(TextSpan(
          text: span.text,
          recognizer: span.onTap == null ?
            null : (TapGestureRecognizer()..onTap = span.onTap),
          style: span.onTap != null ?
            inlineActionStyle : null,
        ));
      }

      return Text.rich(TextSpan(
        style: defaultStyle,
        children: list,
      ));
    }
}
