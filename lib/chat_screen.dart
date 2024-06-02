// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

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
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: const BoxDecoration(
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
      ),
    );
  }
}
