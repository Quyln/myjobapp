import 'package:cached_memory_image/cached_memory_image.dart';
import 'package:flutter/material.dart';
import '../../../../Classes/chat_class.dart';

class TextMessagePerson extends StatelessWidget {
  const TextMessagePerson({
    super.key,
    required this.message,
    this.partnerAvatar,
  });

  final ChatMessage message;
  final String? partnerAvatar;

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
                child: ClipOval(
                  child: SizedBox(
                      width: 40,
                      height: 40,
                      child: CachedMemoryImage(
                        uniqueKey: partnerAvatar!,
                        base64: partnerAvatar,
                        fit: BoxFit.cover,
                      )),
                )),
          ],
          Column(
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
              Container(
                width: message.text.length > 30 ? 250 : null,
                decoration: message.isSender
                    ? BoxDecoration(
                        color: Colors.blue.shade200,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                        ))
                    : const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                        )),
                margin: const EdgeInsets.only(
                    left: 10, bottom: 5, right: 10, top: 2),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Text(
                  message.text,
                  softWrap: true,
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
