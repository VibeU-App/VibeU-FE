import 'package:flutter/material.dart';

import 'otp_box.dart';

class OtpInputSection extends StatefulWidget {
  const OtpInputSection({ super.key, });

  @override
  State<OtpInputSection> createState() => _OtpInputState();
}

class _OtpInputState extends State<OtpInputSection>
  with SingleTickerProviderStateMixin {

  final _otpLength = 6;

  late FocusNode _node;
  late TextEditingController _controller;
  late final AnimationController _animation;
  late final AnimatedBuilder _animatedCursor;

  @override
  void initState() {
    super.initState();
    _node = FocusNode();
    _controller = TextEditingController();
    _animation = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat();
    _animatedCursor = AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Opacity(
          opacity: _animation.value > 0.5 ? 1 : 0,
          child: Container(height: 20, width: 2, color: Colors.black),
        );
      }
    );
  }

  @override
  void dispose() {
    _animation.dispose();
    _controller.dispose();
    _node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: 0.0,
          child: TextField(
            maxLength: _otpLength,
            focusNode: _node,
            controller: _controller,
            keyboardType: TextInputType.number,
          ),
        ),
        GestureDetector(
          onTap: () {
            _node.requestFocus();
          },
          child: ValueListenableBuilder(
            valueListenable: _controller,
            builder: (context, value, w) {
              return Row(
                mainAxisAlignment: .spaceBetween,
                children: List.generate(_otpLength, growable: false,
                  (index) => OtpBox(
                    num: value.text.length > index ? value.text[index] : null,
                    focused: value.text.length == index && _node.hasFocus,
                    animatedCursor: _animatedCursor,
                  )
                )
              );
            }
          )
        )
      ]
    );
  }

}

