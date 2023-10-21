import 'package:flutter/material.dart';
import 'package:myjobapp/Classes/chat_class.dart';

class DotMessage extends StatelessWidget {
  const DotMessage({super.key, required this.status});
  final MessageStatus status;
  @override
  Widget build(BuildContext context) {
    Color dotColor(MessageStatus status) {
      switch (status) {
        case MessageStatus.not_sent:
          return Colors.red;
        case MessageStatus.not_view:
          return Colors.grey;
        case MessageStatus.viewed:
          return Colors.blue;
        default:
          return Colors.transparent;
      }
    }

    return Container(
      width: 12,
      height: 12,
      decoration:
          BoxDecoration(color: dotColor(status), shape: BoxShape.circle),
      child: Icon(
        status == MessageStatus.not_sent ? Icons.close : Icons.done,
        color: Colors.white,
        size: 8,
      ),
    );
  }
}
