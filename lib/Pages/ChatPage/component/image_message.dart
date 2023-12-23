import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../Classes/chat_class.dart';

class ImageMessage extends StatelessWidget {
  const ImageMessage({super.key, required this.message});
  final ChatMessage message;
  @override
  Widget build(BuildContext context) {
    return Row(
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
        Padding(
          padding:
              const EdgeInsets.only(right: 10, bottom: 5, top: 5, left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                  visible: !message.isSender,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 10, bottom: 2),
                    child: Text(
                      message.name,
                      style: const TextStyle(fontSize: 12),
                    ),
                  )),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: message.imageb64 != null
                            ? Image.memory(
                                base64Decode(message.imageb64!),
                                fit: BoxFit.cover,
                                height: MediaQuery.of(context).size.width * 0.5,
                              )
                            : const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
