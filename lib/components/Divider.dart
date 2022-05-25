import 'package:flutter/material.dart';
import 'package:sublimed_health/components/constants.dart';

class PageDivider extends StatelessWidget {
  const PageDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.02),
      width: size.width * 0.8,
      child: Row(
        children: [
          buildDivider(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Settings",
              style: TextStyle(color: kPrimaryColor, fontSize: 20),
            ),
          ),
          buildDivider(),
        ],
      ),
    );
  }

  Expanded buildDivider() {
    return const Expanded(
      child: Divider(
        color: kPrimaryColor2,
        height: 2.2,
      ),
    );
  }
}
