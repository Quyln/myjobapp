enum MessageStatus { not_sent, not_view, viewed }

class ChatMessage {
  final String text;
  String messageType;
  MessageStatus messageStatus;
  final bool isSender;
  final int timestamp;
  final String avatar;
  final String name;
  String? imageb64;
  String? quoteMessage;

  ChatMessage(
      {required this.text,
      required this.messageType,
      required this.messageStatus,
      required this.timestamp,
      required this.name,
      this.imageb64,
      this.quoteMessage,
      required this.avatar,
      required this.isSender});
}
