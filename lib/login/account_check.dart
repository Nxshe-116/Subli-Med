import 'package:flutter/material.dart';
import '../components/constants.dart';
import '../signup/signup/sign_up.dart';

class AccountCheck extends StatelessWidget {
  final bool login;

  const AccountCheck({
    Key? key,
    this.login = true,
  }) : super(key: key);

  get press => null;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        login
            ? const Text(
                "Don't Have an Account?",
                style: TextStyle(color: Colors.black),
              )
            : const Text("Already Have an Account?",
                style: TextStyle(color: Colors.white)),
        GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SignUp();
                  },
                ),
              );
            },
            child: Text(
              login ? " Sign Up" : " Sign In",
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: kPrimaryColor),
            ))
      ],
    );
  }
}
