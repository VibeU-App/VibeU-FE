import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class VibeTextSpan extends StatefulWidget {
  final TextStyle defaultStyle;
  final TextStyle inlineActionStyle;
  final List<TextSpan> spans;

  VibeTextSpan({
    super.key,
    required this.defaultStyle,
    required this.inlineActionStyle,
  }) : spans = [];

  @override
  State<VibeTextSpan> createState() => _VibeTextSpanState();

  void text(String text) {
    spans.add(TextSpan(
      text: text,
      style: defaultStyle,
    ));
  }

  void link(String text, [Future<void> Function()? onTap]) {
    spans.add(TextSpan(
      text: text,
      style: inlineActionStyle,
      recognizer: TapGestureRecognizer()..onTap = onTap,
    ));
  }
}

class _VibeTextSpanState extends State<VibeTextSpan> {
  @override
  void dispose() {
    for (var s in widget.spans) {
      s.recognizer?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(
      style: widget.defaultStyle,
      children: widget.spans,
    ));
  }
}
