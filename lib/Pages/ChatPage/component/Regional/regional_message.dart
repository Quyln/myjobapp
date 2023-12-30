import 'package:flutter/material.dart';
import 'package:myjobapp/Classes/component/list_users_info.dart';
import 'package:myjobapp/Pages/ChatPage/component/audio_message.dart';
import 'package:myjobapp/Pages/ChatPage/component/dot_message.dart';
import 'package:myjobapp/Pages/ChatPage/component/Regional/regional_text_message.dart';
import 'package:myjobapp/Pages/ChatPage/component/Regional/regional_image_message.dart';
import '../../../../Classes/chat_class.dart';

class MessageSocial extends StatefulWidget {
  const MessageSocial(
      {super.key, required this.message, this.partnerAvatar, this.roomIdList});
  final ChatMessage message;
  final String? partnerAvatar;

  final List<UserForSearch>? roomIdList;

  @override
  State<MessageSocial> createState() => _MessageSocialState();
}

class _MessageSocialState extends State<MessageSocial> {
  @override
  Widget build(BuildContext context) {
    Widget messageContaint(ChatMessage message) {
      switch (message.messageType) {
        case 'text':
          return TextMessageSocial(message: message);
        case 'image':
          return ImageMessageSocial(message: message);
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
