import 'package:flutter/material.dart';
import 'package:myjobapp/Pages/ChatPage/component/audio_message.dart';
import 'package:myjobapp/Pages/ChatPage/component/dot_message.dart';
import 'package:myjobapp/Pages/ChatPage/component/text_message.dart';
import 'package:myjobapp/Pages/ChatPage/component/video_message.dart';

import '../../Classes/chat_class.dart';

class Message extends StatelessWidget {
  const Message({
    super.key,
    required this.message,
  });

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    Widget messageContaint(ChatMessage message) {
      switch (message.messageType) {
        case ChatMessageType.text:
          return TextMessage(message: message);
        case ChatMessageType.audio:
          return AudioMessage(message: message);
        case ChatMessageType.video:
          return VideoMessage(message: message);
        default:
          return const SizedBox();
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment:
            message.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!message.isSender) ...[
            const CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey,
              backgroundImage: NetworkImage(
                  'https://keomoi.com/wp-content/uploads/2019/05/anh-gai-xinh-nhat-ban-2019-hinh-6.jpg'),
            )
          ],
          messageContaint(message),
          if (message.isSender)
            DotMessage(
              status: message.messageStatus,
            ),
        ],
      ),
    );
  }
}
