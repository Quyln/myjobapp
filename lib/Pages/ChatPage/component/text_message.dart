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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isSender) ...[
            Padding(
              padding: const EdgeInsets.only(
                top: 12,
              ),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey,
                backgroundImage: NetworkImage(message.avatar),
              ),
            ),
          ],
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                  visible: !message.isSender,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 20, bottom: 2),
                    child: Text(
                      message.name,
                      style: const TextStyle(fontSize: 14),
                    ),
                  )),
              Container(
                width: message.text.length > 50 ? 250 : null,
                decoration: BoxDecoration(
                    color:
                        message.isSender ? Colors.blue.shade200 : Colors.white,
                    borderRadius: BorderRadius.circular(16)),
                margin: const EdgeInsets.only(left: 10, bottom: 5, right: 10),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Text(
                  message.text,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
