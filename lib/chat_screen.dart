import 'package:all_bluetooth/all_bluetooth.dart';
import 'package:flutter/material.dart';
import 'screens/messagingscreen.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_4.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('CHATS'),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: () {}),
          IconButton(icon: const Icon(Icons.add), onPressed: () {}),
        ],
      ),
       body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ChatBubble(
                    clipper: ChatBubbleClipper4(type: message.isMe ? BubbleType.sendBubble : BubbleType.receiverBubble),
                    alignment: message.isMe ? Alignment.topRight : Alignment.topLeft,
                    child: Text(message.message),
                  ),
                );
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: messageController,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  final messageText = messageController.text;
                  bluetooth.sendMessage(messageText); 
                  messageController.clear();
                  messages.add(
                    Message(
                      message: messageText,
                      isMe: true,
                    ),
                  );
                  setState(() {});
                },
                icon: const Icon(Icons.send),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class Message {
  final String message;
  final bool isMe;

  Message({required this.message, required this.isMe});
}
    /*  body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromRGBO(140, 139, 197, 1), Color.fromRGBO(31, 27, 193, 1)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView.builder(
          itemCount: 5, // number of chat items
          itemBuilder: (context, index) {
            return const ListTile(
              leading: CircleAvatar(
                // backgroundImage: AssetImage('path_to_image'), // path to your image
              ),
              title: Text('Contact Name: Message snippet'),
              subtitle: Text('10:00 AM'),
              trailing: Icon(Icons.message, color: Colors.white),
            );
          },
        ),
      ),*/



