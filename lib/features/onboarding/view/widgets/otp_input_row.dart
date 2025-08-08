import 'package:flutter/material.dart';

class OtpInputRow extends StatefulWidget {
  const OtpInputRow({super.key});

  @override
  State<OtpInputRow> createState() => _OtpInputRowState();
}

class _OtpInputRowState extends State<OtpInputRow> {
  final int _otpLength = 5;
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  String otpCode = ''; // 🔐 This stores the OTP

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(_otpLength, (_) => TextEditingController());
    _focusNodes = List.generate(_otpLength, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (var c in _controllers) {
      c.dispose();
    }
    for (var f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.length == 1) {
      if (index < _otpLength - 1) {
        FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
      } else {
        _focusNodes[index].unfocus(); // Last box
      }
    } else if (value.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
    }

    // 👇 Check if all fields are filled and store OTP
    if (_controllers.every((c) => c.text.isNotEmpty)) {
      setState(() {
        otpCode = _controllers.map((c) => c.text).join();
      });
      print("OTP Entered: $otpCode"); // You can use it now
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(_otpLength, (index) {
            return SizedBox(
              width: 50,
              child: TextField(
                controller: _controllers[index],
                focusNode: _focusNodes[index],
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                maxLength: 1,
                onChanged: (value) => _onChanged(value, index),
                decoration: const InputDecoration(
                  counterText: '',
                  border: OutlineInputBorder(),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
