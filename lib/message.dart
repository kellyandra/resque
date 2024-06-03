// Defines the Message class to represent a chat message.
class Message {
  // The text of the message.
  final String message;
  
  // A boolean to determine if the message was sent by the current user.
  final bool isMe;

  // Constructor for the Message class with required fields.
  Message({required this.message, required this.isMe});
}
