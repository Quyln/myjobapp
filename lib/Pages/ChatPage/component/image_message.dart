import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../Classes/chat_class.dart';

class ImageMessage extends StatefulWidget {
  const ImageMessage({super.key, required this.message});
  final ChatMessage message;

  @override
  State<ImageMessage> createState() => _ImageMessageState();
}

class _ImageMessageState extends State<ImageMessage> {
  double _scale = 1.0;
  TransformationController _transformationController =
      TransformationController();

  void _handleDoubleTap() {
    double newScale = _scale == 1.0 ? 2.0 : 1.0;
    setState(() {
      _scale = newScale;
    });
    _transformationController.value = Matrix4.identity()
      ..scale(newScale, newScale);
  }

  void _handleInteractionUpdate(ScaleUpdateDetails details) {
    double newScale = _scale * details.scale;
    if (newScale >= 0.5 && newScale <= 4.0) {
      setState(() {
        _scale = newScale;
      });
      _transformationController.value = Matrix4.identity()
        ..scale(newScale, newScale);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!widget.message.isSender) ...[
          Padding(
            padding: const EdgeInsets.only(
              top: 12,
            ),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey,
              backgroundImage: NetworkImage(widget.message.avatar),
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
                  visible: !widget.message.isSender,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 10, bottom: 2),
                    child: Text(
                      widget.message.name,
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
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                backgroundColor: Colors.transparent,
                                child: GestureDetector(
                                  onDoubleTap: _handleDoubleTap,
                                  child: InteractiveViewer(
                                    transformationController:
                                        _transformationController,
                                    onInteractionStart: (_) =>
                                        _transformationController.value =
                                            Matrix4.identity(),
                                    onInteractionUpdate:
                                        _handleInteractionUpdate,
                                    maxScale: 4.0, // Giá trị tối đa để phóng to
                                    minScale:
                                        0.5, // Giá trị tối thiểu để thu nhỏ
                                    panEnabled: true, // Cho phép kéo
                                    scaleEnabled:
                                        true, // Cho phép phóng to/thu nhỏ
                                    child: Image.memory(
                                        base64Decode(widget.message.imageb64!)),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: widget.message.imageb64 != null
                              ? Image.memory(
                                  base64Decode(widget.message.imageb64!),
                                  fit: BoxFit.cover,
                                  height:
                                      MediaQuery.of(context).size.width * 0.5,
                                )
                              : const SizedBox.shrink(),
                        ),
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
