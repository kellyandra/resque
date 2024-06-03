import 'package:all_bluetooth/all_bluetooth.dart';
import 'package:resque/main.dart';
import 'package:resque/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';

// StatefulWidget to handle dynamic interaction in a chat screen.
class MessageScreen extends StatefulWidget {
  final BluetoothDevice device; // Bluetooth device to connect for communication.

  const MessageScreen({Key? key, required this.device}) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final messageController = TextEditingController(); // Controls the text input field.

  final messages = <Message>[]; // List of messages to display in the chat.

  @override
  void initState() {
    super.initState();
    // Listen for incoming data from the Bluetooth connection.
    allBluetooth.listenForData.listen((event) {
      messages.add(Message(
        message: event.toString(), // Convert event data to string and add to messages list.
        isMe: false, // Incoming messages are marked as not sent by the user.
      ));
      setState(() {}); // Trigger UI update.
    });
  }

  @override
  void dispose() {
    super.dispose();
    messageController.dispose(); // Dispose of the controller when the widget is removed.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            ElevatedButton(
              onPressed: () {
                allBluetooth.closeConnection(); // Close Bluetooth connection.
              },
              child: const Text("CLOSE"),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: messages.length, // Build an item for each message.
                itemBuilder: (context, index) {
                  final message = messages[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ChatBubble(
                      clipper: ChatBubbleClipper4(
                        type: message.isMe
                            ? BubbleType.sendBubble // Style for sent messages.
                            : BubbleType.receiverBubble, // Style for received messages.
                      ),
                      alignment:
                          message.isMe ? Alignment.topRight : Alignment.topLeft, // Align based on sender.
                      child: Text(message.message), // Display message text.
                    ),
                  );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController, // Text input for new messages.
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(), // Style for the text field.
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    final message = messageController.text;
                    allBluetooth.sendMessage(message); // Send message over Bluetooth.
                    messageController.clear(); // Clear input after sending.
                    messages.add(
                      Message(
                        message: message,
                        isMe: true, // Mark the message as sent by the user.
                      ),
                    );
                    setState(() {}); // Update UI to show the new message.
                  },
                  icon: const Icon(Icons.send), // Send button icon.
                )
              ],
            )
          ],
        ));
  }
}
