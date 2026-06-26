import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'otp_box.dart';

class OtpInputSection extends StatefulWidget {
  const OtpInputSection({ super.key, });

  @override
  State<OtpInputSection> createState() => _OtpInputState();
}

class _OtpInputState extends State<OtpInputSection>{

  static const _otpLength = 6;

  late FocusNode _node;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _node = FocusNode();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Offstage(
          child: TextField(
            maxLength: _otpLength,
            focusNode: _node,
            controller: _controller,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(_otpLength),
            ],
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

