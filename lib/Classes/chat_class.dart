enum ChatMessageType { text, audio, image, video }

enum MessageStatus { not_sent, not_view, viewed }

class ChatMessage {
  final String text;
  final ChatMessageType messageType;
  final MessageStatus messageStatus;
  final bool isSender;

  ChatMessage(
      {required this.text,
      required this.messageType,
      required this.messageStatus,
      required this.isSender});
}

List demoChatMessage = [
  ChatMessage(
      text: 'Hi Baby',
      messageType: ChatMessageType.text,
      messageStatus: MessageStatus.viewed,
      isSender: true),
  ChatMessage(
      text: '',
      messageType: ChatMessageType.audio,
      messageStatus: MessageStatus.viewed,
      isSender: false),
  ChatMessage(
      text: '',
      messageType: ChatMessageType.video,
      messageStatus: MessageStatus.viewed,
      isSender: true),
  ChatMessage(
      text: 'Bị gì rồi à?',
      messageType: ChatMessageType.text,
      messageStatus: MessageStatus.not_sent,
      isSender: true),
  ChatMessage(
      text: 'Nhìn ổn áp đó',
      messageType: ChatMessageType.text,
      messageStatus: MessageStatus.viewed,
      isSender: false),
  ChatMessage(
      text: 'Ok duyệt',
      messageType: ChatMessageType.text,
      messageStatus: MessageStatus.not_view,
      isSender: true),
];
