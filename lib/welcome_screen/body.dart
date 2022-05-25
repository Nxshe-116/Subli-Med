import 'package:flutter/material.dart';
import '../components/background.dart';
import '../components/constants.dart';
import '../components/rounded_button.dart';
import '../components/rounded_button2.dart';
import '../login/login_screen.dart';
import '../signup/signup/sign_up.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
        child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: size.height * 0.5,
          ),
          const Text(
            "Welcome to SubliMed",
            style: TextStyle(color: kPrimaryColor, fontSize: 25),
          ),
          RoundedButton(
            text: "Sign In" ,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const LoginScreen();
                  },
                ),
              );
            },
          ),
          RoundedButton2(
            text: "Sign Up",
            color: kPrimaryColor2,
            textColor: kPrimaryColor,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SignUp();
                  },
                ),
              );
            },
          ),
        ],
      ),
    ));
  }
}
