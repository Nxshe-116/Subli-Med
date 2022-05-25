import 'package:flutter/material.dart';

import '../components/constants.dart';


class SocialIcon extends StatelessWidget {
  final String iconSrc;
  final Function press;
  const SocialIcon({
     Key? key, required this.iconSrc, required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: kPrimaryColor),
              color: Colors.white,
              shape: BoxShape.circle
          ),
          child:Image.asset(iconSrc, height: 30, width: 30,)
      ),
    );
  }
}

