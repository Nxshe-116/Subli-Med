import 'package:flutter/material.dart';

import '../../components/constants.dart';
import '../menu.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text(
          "Settings",
          style: TextStyle(color: kPrimaryColor),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: kPrimaryColor),
          onPressed: () {

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                    const HomeScreen()));
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding:  const EdgeInsets.all(32.0),
        child:  Center(
          child: Column(
            children: const [Text('Hello World')],
          ),
        ),
      ),
    );;
  }
}
