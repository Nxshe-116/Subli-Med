

import 'package:flutter/material.dart';
import 'package:sublimed_health/mainComponents/chats/widgets/messages_widget.dart';
import 'package:sublimed_health/mainComponents/chats/widgets/new_message_widget.dart';
import 'package:sublimed_health/mainComponents/chats/widgets/profile_header_widget.dart';

import '../../model/user.dart';

class ChatPage extends StatefulWidget {
  final User user;

  const ChatPage({
    required this.user,
    Key? key,
  }) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: const Color.fromARGB(255, 9, 16, 67),
        body: SafeArea(
          child: Column(
            children: [
              ProfileHeaderWidget(name: widget.user.name),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  child: MessagesWidget(idUser: widget.user.idUser),
                ),
              ),
              NewMessageWidget(idUser: widget.user.idUser)
            ],
          ),
        ),
      );
}
