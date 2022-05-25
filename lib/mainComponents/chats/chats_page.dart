import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sublimed_health/components/constants.dart';
import 'package:sublimed_health/mainComponents/chats/widgets/chat_body_widget.dart';
import 'package:sublimed_health/mainComponents/chats/widgets/chat_header_widget.dart';
import 'package:sublimed_health/main_menu/menu.dart';




import '../../api/firebase_api.dart';
import '../../model/user.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            "Chats",
            style: TextStyle(color: kPrimaryColor),
          ),
          centerTitle: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: kPrimaryColor),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()));
              }),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: StreamBuilder<List<User>>(
            stream: FirebaseApi.getUsers(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator());
                default:
                  if (snapshot.hasError) {
                    if (kDebugMode) {
                      print(snapshot.error);
                    }
                    return buildMessage('Something Went Wrong Try later',
                        'https://storyset.com/illustration/feeling-sorry/rafiki');
                  } else {
                    final users = snapshot.data;

                    if (users!.isEmpty) {
                      return buildMessage('No Users Found',
                          'https://storyset.com/illustration/404-error-with-portals/amico#407BFFFF&hide=&hide=complete');
                    } else {
                      return Column(
                        children: [
                          ChatHeaderWidget(users: users),
                          ChatBodyWidget(users: users)
                        ],
                      );
                    }
                  }
              }
            },
          ),
        ),
      );

  Widget buildMessage(String text, String url) => Center(
        child: Column(
          children: [
            SizedBox(height: 40, width: 40, child: Image.network(url)),
            const SizedBox(
              height: 10,
            ),
            Text(
              text,
              style: const TextStyle(fontSize: 24, color: kPrimaryColor),
            ),
          ],
        ),
      );
}
