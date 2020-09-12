import 'package:flutter/material.dart';
import 'package:itjobs/widgets/ChatMessage.dart';
import '../models/ChatUser.dart';
import '../widgets/ChatUser.dart';

class ChatScreen extends StatefulWidget {

  static const routeName = "/chat";

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final List<ChatUser> users = [
    ChatUser(isOnline: true, name: "Vishal Kumar", chatHistory: []),
    ChatUser(isOnline: true, name: "Sandesh Mishra", chatHistory: []),
    ChatUser(isOnline: false, name: "Rahul Sharma", chatHistory: []),
    ChatUser(isOnline: false, name: "Mohammed", chatHistory: []),
    ChatUser(isOnline: false, name: "Shubham Mehra", chatHistory: [])
  ];
  ChatUser selectedUser;
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedUser = users[0];
  }

  void _setCurrentUser(ChatUser selUser) {
    setState(() {
      selectedUser = selUser;
    });
  }

  void _addMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        selectedUser.chatHistory.add(_messageController.text);
      });
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSelectedUserOnline = selectedUser.isOnline;
    final chatHistory = selectedUser.chatHistory;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        // child: ChatMessage(
        //   index: 0,
        //   message: "Hello There! I am Abhishek, I am very excited to be working with you!"
        // ),
        child: Column(
          children: [
            Container(
              height: 80,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GestureDetector(
                      child: Icon(Icons.arrow_back),
                      onTap: () => Navigator.of(context).pop(),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(selectedUser.name, style: TextStyle(fontSize: 24)),
                      Text(isSelectedUserOnline? "Online now!": "Offline", style: TextStyle(color: isSelectedUserOnline? Colors.green: Colors.grey))
                    ],
                  )
                ],
              )
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              color: Colors.grey[200],
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: users.map((user) => ChatUserAvatar(chatUser: user, handleUserTap: _setCurrentUser,)).toList(),
                ),
              ),
            ),
            Expanded(
              child: chatHistory.length == 0?
              Center(child: Text("Start a conversation!")):
              ListView.separated(
                itemBuilder: (context, index) => ChatMessage(index: index, message: selectedUser.chatHistory[index],), 
                separatorBuilder: (_, __) => SizedBox(height: 5),
                itemCount: selectedUser.chatHistory.length
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
              color: Colors.grey[100],
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 6,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          labelText: "Enter message"
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: IconButton(
                        onPressed: _addMessage,
                        icon: Icon(Icons.send)
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}