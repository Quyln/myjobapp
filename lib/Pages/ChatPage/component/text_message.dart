import 'package:flutter/material.dart';

import '../../../Classes/chat_class.dart';

class TextMessage extends StatelessWidget {
  const TextMessage({
    super.key,
    required this.message,
  });

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: message.isSender ? Colors.blue : Colors.black45,
            borderRadius: BorderRadius.circular(30)),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Text(
          message.text,
          style: const TextStyle(color: Colors.white),
        ));
  }
}
