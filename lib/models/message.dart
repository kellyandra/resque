class Message {
  final String id;
  final String text;
  final DateTime dateTime;
  final String senderId;
  final bool isRead;

  Message({
    required this.id,
    required this.text,
    required this.dateTime,
    required this.senderId,
    this.isRead = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'dateTime': dateTime.toIso8601String(),
      'senderId': senderId,
      'isRead': isRead,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'],
      text: map['text'],
      dateTime: DateTime.parse(map['dateTime']),
      senderId: map['senderId'],
      isRead: map['isRead'] ?? false,
    );
  }
}
