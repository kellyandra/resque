import 'package:all_bluetooth/all_bluetooth.dart';
import 'package:resque/main.dart';
import 'package:resque/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';

class MessageScreen extends StatefulWidget {
  final BluetoothDevice device;

  const MessageScreen({Key? key, required this.device}) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final messageController = TextEditingController();

  final messages = <Message>[];

  @override
  void initState() {
    super.initState();
    allBluetooth.listenForData.listen((event) {
      messages.add(Message(
        message: event.toString(),
        isMe: false,
      ));
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            ElevatedButton(
              onPressed: () {
                allBluetooth.closeConnection();
              },
              child: const Text("CLOSE"),
            ),
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
                      clipper: ChatBubbleClipper4(
                        type: message.isMe
                            ? BubbleType.sendBubble
                            : BubbleType.receiverBubble,
                      ),
                      alignment:
                          message.isMe ? Alignment.topRight : Alignment.topLeft,
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
                    final message = messageController.text;
                    allBluetooth.sendMessage(message);
                    messageController.clear();
                    messages.add(
                      Message(
                        message: message,
                        isMe: true,
                      ),
                    );
                    setState(() {});
                  },
                  icon: const Icon(Icons.send),
                )
              ],
            )
          ],
        ));
  }
}