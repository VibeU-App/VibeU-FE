import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'otp_box.dart';

class OtpInputSection extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode node;
  final int otpLength;

  const OtpInputSection({
    super.key,
    required this.controller,
    required this.node,
    this.otpLength = 6,
  });

  @override
  State<OtpInputSection> createState() => _OtpInputState();
}

class _OtpInputState extends State<OtpInputSection>{

  late FocusNode _node;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _node = widget.node;
    _controller = widget.controller;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Offstage(
          child: TextField(
            maxLength: widget.otpLength,
            focusNode: _node,
            controller: _controller,
            keyboardType: .number,
            enableInteractiveSelection: false,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(widget.otpLength),
            ],
            onChanged: (str) {
              if (_controller.text.length == widget.otpLength) {
                _node.unfocus();
              }
            },
          ),
        ),
        GestureDetector(
          onTap: () {
            _node.requestFocus();
          },
          child: ListenableBuilder(
            listenable: Listenable.merge([ _controller, _node ]),
            builder: (context, w) {
              return Row(
                mainAxisAlignment: .spaceBetween,
                children: List.generate(widget.otpLength, growable: false,
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
