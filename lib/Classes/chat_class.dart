enum ChatMessageType { text, audio, image, video }

enum MessageStatus { not_sent, not_view, viewed }

class ChatMessage {
  final String text;
  final ChatMessageType messageType;
  final MessageStatus messageStatus;
  final bool isSender;
  final int timestamp;
  final String avatar;
  final String name;
  String? quoteMessage;

  ChatMessage(
      {required this.text,
      required this.messageType,
      required this.messageStatus,
      required this.timestamp,
      required this.name,
      required this.avatar,
      required this.isSender});
}
