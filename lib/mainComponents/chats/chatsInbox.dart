import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../api/firebase_api.dart';
import '../../model/users.dart';
import 'chats_page.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseApi.addRandomUsers(Users.initUsers);

  runApp(const MyChats());
}

class MyChats extends StatelessWidget {
  static const String title = 'Chat Inbox';

  const MyChats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(

    debugShowCheckedModeBanner: false,

    title: title,
    theme: ThemeData(primarySwatch: Colors.indigo),
    home: const ChatsPage(),
  );
}
