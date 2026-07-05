import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'otp_box.dart';

class OtpInputSection extends StatefulWidget {
  final TextEditingController controller;

  const OtpInputSection({
    super.key,
    required this.controller,
  });

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
    _controller = widget.controller;
  }

  @override
  void dispose() {
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
            keyboardType: .number,
            enableInteractiveSelection: false,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(_otpLength),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            _node.requestFocus();
            // _moveCursorToEnd();
          },
          child: ListenableBuilder(
            listenable: Listenable.merge([ _controller, _node ]),
            builder: (context, w) {
              return Row(
                mainAxisAlignment: .spaceBetween,
                children: List.generate(_otpLength, growable: false,
                  (index) => OtpBox(
                    num: _controller.text.length > index ? _controller.text[index] : null,
                    focused: _controller.text.length == index && _node.hasFocus,
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
