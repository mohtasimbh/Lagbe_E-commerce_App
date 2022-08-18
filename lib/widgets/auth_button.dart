import 'package:flutter/material.dart';
import 'package:grocery_app/widgets/text_widget.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    Key? key,
    required this.fct,
    required this.buttonText,
    this.primary = const Color(0xFF47C272),
  }) : super(key: key);
  final Function fct;
  final String buttonText;
  final Color primary;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: primary, // background (button) color
          ),
          onPressed: () {
            fct();
          },
          child: TextWidget(
            text: buttonText,
            textSize: 18,
            color: Colors.white,
          )),
    );
  }
}