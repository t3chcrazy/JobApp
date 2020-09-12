import 'package:flutter/material.dart';
import '../models/ChatUser.dart';

class ChatUserAvatar extends StatelessWidget {

  final ChatUser chatUser;
  final Function handleUserTap;

  ChatUserAvatar({@required this.chatUser, @required this.handleUserTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => handleUserTap(chatUser),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 10,
              child: Text(chatUser.name[0].toUpperCase(), style: TextStyle(fontSize: 8, color: Colors.white)),
            ),
            Text(chatUser.name, style: TextStyle(fontSize: 10))
          ],
        ),
      ),
    );
  }
}