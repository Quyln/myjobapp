import 'package:flutter/material.dart';
import 'package:myjobapp/Classes/component/list_users_info.dart';
import 'package:myjobapp/Pages/ChatPage/component/audio_message.dart';
import 'package:myjobapp/Pages/ChatPage/component/dot_message.dart';
import 'package:myjobapp/Pages/ChatPage/component/PersonGroup/person_image_message.dart';
import 'package:myjobapp/Pages/ChatPage/component/PersonGroup/person_text_message.dart';
import '../../../../Classes/chat_class.dart';

class MessagePerson extends StatefulWidget {
  const MessagePerson(
      {super.key,
      required this.message,
      this.groupName,
      required this.partnerAvatar,
      this.roomIdList});
  final ChatMessage message;
  final String? groupName;
  final String partnerAvatar;

  final List<UserForSearch>? roomIdList;

  @override
  State<MessagePerson> createState() => _MessagePersonState();
}

class _MessagePersonState extends State<MessagePerson> {
  @override
  Widget build(BuildContext context) {
    Widget messageContaint(ChatMessage message) {
      switch (message.messageType) {
        case 'text':
          return TextMessagePerson(
            message: message,
            partnerAvatar: widget.partnerAvatar,
          );
        case 'image':
          return ImageMessagePerson(
            message: message,
            partnerAvatar: widget.partnerAvatar,
          );
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
