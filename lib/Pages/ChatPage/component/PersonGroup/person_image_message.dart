import 'dart:convert';
import 'package:flutter/material.dart';
import '../../../../Classes/chat_class.dart';

class ImageMessagePerson extends StatefulWidget {
  const ImageMessagePerson(
      {super.key, required this.message, required this.partnerAvatar});
  final ChatMessage message;
  final String partnerAvatar;

  @override
  State<ImageMessagePerson> createState() => _ImageMessagePersonState();
}

class _ImageMessagePersonState extends State<ImageMessagePerson> {
  final TransformationController _transformationController =
      TransformationController();
  Offset doubleTapOffset = Offset.zero;
  int doubleTapCount = 0;
  double scale = 1.0;

  // void handleDoubleTap() {
  //   setState(() {
  //     doubleTapCount++;
  //     if (doubleTapCount == 1) {
  //       scale = 1.5;
  //     } else if (doubleTapCount == 2) {
  //       scale = 2.0;
  //     } else {
  //       doubleTapCount = 0;
  //       scale = 1.0;
  //     }
  //     final Matrix4 currentMatrix = _transformationController.value;
  //     final Matrix4 translationMatrix = Matrix4.translationValues(
  //         -doubleTapOffset.dx, -doubleTapOffset.dy, 0.0);
  //     final Matrix4 scaleMatrix = Matrix4.identity()..scale(scale);
  //     final Matrix4 combinedMatrix =
  //         translationMatrix * scaleMatrix * translationMatrix.invert();
  //     final Matrix4 newMatrix = combinedMatrix * currentMatrix;

  //     _transformationController.value = newMatrix;
  //   });
  // }

  // void handleDoubleTapDown(TapDownDetails details) {
  //   doubleTapOffset = details.localPosition;
  // }

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
              child: ClipOval(
                child: SizedBox(
                    width: 40,
                    height: 40,
                    child: Image.memory(
                      base64Decode(widget.partnerAvatar),
                      fit: BoxFit.cover,
                    )),
              )),
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
                    alignment: widget.message.isSender
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    children: [
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                shadowColor: Colors.white10,
                                backgroundColor: Colors.transparent,
                                child: GestureDetector(
                                  // onDoubleTapDown: handleDoubleTapDown,
                                  // onDoubleTap: handleDoubleTap,
                                  child: InteractiveViewer(
                                    clipBehavior: Clip.none,
                                    maxScale: 3,
                                    minScale: 0.5,
                                    panEnabled: true,
                                    scaleEnabled: true,
                                    transformationController:
                                        _transformationController,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.memory(base64Decode(
                                          widget.message.imageb64!)),
                                    ),
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
