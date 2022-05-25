import 'package:flutter/material.dart';

import '../signup/signup/sign_up.dart';
import 'constants.dart';

class RoundedButton2 extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;

  const RoundedButton2({
     Key? key,
    required this.text,
    required this.press,
    this.color = kPrimaryColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: TextButton(
          onPressed: () {
      Navigator.push(
      context,
      MaterialPageRoute(
      builder: (context) {
      return const SignUp();
      },
      ),
      );
      },
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            backgroundColor: color,
            primary: textColor,
          ),
          child: Text(text),
        ),
      ),
    );
  }
}
