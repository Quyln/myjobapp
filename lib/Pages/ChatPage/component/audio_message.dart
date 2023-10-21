import 'package:flutter/material.dart';

import '../../../Classes/chat_class.dart';

class AudioMessage extends StatelessWidget {
  const AudioMessage({super.key, required this.message});
  final ChatMessage message;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.24,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: message.isSender ? Colors.blue : Colors.black45),
      child: const Row(children: [
        Icon(
          Icons.play_arrow,
          color: Colors.white,
          size: 20,
        ),
        Icon(
          Icons.graphic_eq,
          color: Colors.white,
          size: 20,
        ),
        Spacer(),
        Text(
          '0:30',
          style: TextStyle(color: Colors.white),
        )
      ]),
    );
  }
}
