import 'package:flutter/material.dart';
import 'package:myjobapp/Pages/ChatPage/component/audio_message.dart';
import 'package:myjobapp/Pages/ChatPage/component/dot_message.dart';
import 'package:myjobapp/Pages/ChatPage/component/text_message.dart';
import 'package:myjobapp/Pages/ChatPage/component/image_message.dart';
import '../../Classes/chat_class.dart';

class Message extends StatefulWidget {
  const Message({
    super.key,
    required this.message,
  });
  final ChatMessage message;

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  @override
  Widget build(BuildContext context) {
    Widget messageContaint(ChatMessage message) {
      switch (message.messageType) {
        case 'text':
          return TextMessage(message: message);
        case 'image':
          return ImageMessage(message: message);
        default:
          return AudioMessage(message: message);
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: widget.message.isSender
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          messageContaint(widget.message),
          if (widget.message.isSender)
            DotMessage(
              status: widget.message.messageStatus,
            ),
        ],
      ),
    );
  }
}
