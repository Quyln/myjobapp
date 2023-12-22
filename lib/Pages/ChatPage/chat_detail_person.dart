import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myjobapp/Pages/ChatPage/message.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Classes/chat_class.dart';

class DetailPersonChatPage extends StatefulWidget {
  const DetailPersonChatPage(
      {super.key,
      required this.chatRoomId,
      required this.partnerAvatar,
      required this.partnerName});
  final String chatRoomId;
  final String partnerAvatar;
  final String partnerName;

  @override
  State<DetailPersonChatPage> createState() => _DetailPersonChatPageState();
}

class _DetailPersonChatPageState extends State<DetailPersonChatPage> {
  ScrollController _scrollController = ScrollController();
  TextEditingController _inputcontroller = TextEditingController();

  List<ChatMessage> chatMessageList = [];
  List<ChatMessage> latestChatMessages = [];

  FirebaseFirestore db = FirebaseFirestore.instance;
  String? quoteChatMessage;
  bool isQuoting = false;
  bool hasNewMessage = false;
  String roomId = '';
  bool reachBottom = false;
  XFile? image;
  XFile? result;
  String? base64Image;

  @override
  void initState() {
    super.initState();
    getChat();
    _scrollController.addListener(checkScroolBottom);
  }

  void getChat() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String myUserId = pref.getString('userid') ?? '';
    // doan nay la de lang nghe Firebase
    final docRef = db.collection("personchat").doc(widget.chatRoomId);
    docRef.snapshots().listen(
      (event) {
        if (roomId != widget.chatRoomId) {
          setState(() {
            latestChatMessages = [];
          });
        }
        // covert data json tu Firebase thanh Class chatMessage
        chatMessageList = event
                .data()
                ?.entries
                .map((e) => ChatMessage(
                    text: e.value['content'],
                    messageType: ChatMessageType.text,
                    timestamp: e.value['timestamp'],
                    name: e.value['name'],
                    messageStatus: MessageStatus.viewed,
                    avatar: e.value['avatar'],
                    isSender: e.value['userid'] == myUserId))
                .toList() ??
            [];
        if (mounted) {
          setState(() {
            // sap xep thu tu chat theo timestamp
            chatMessageList.sort((a, b) {
              return a.timestamp.compareTo(b.timestamp);
            });
          });
        }

        // Kiểm tra xem có tin nhắn mới hay không
        if (latestChatMessages.isNotEmpty &&
            chatMessageList.length > latestChatMessages.length &&
            !chatMessageList.last.isSender) {
          if (mounted) {
            setState(() {
              hasNewMessage = true;
            });
          }
        }
        latestChatMessages = List.from(chatMessageList);
        roomId = widget.chatRoomId;
      },
      onError: (error) => print("Listen failed: $error"),
    );
  }

  Future<void> sendChat() async {
    if (_inputcontroller.text.trim().isEmpty) {
      return;
    }
    SharedPreferences pref = await SharedPreferences.getInstance();
    String myUserId = pref.getString('userid') ?? '';
    String userName = pref.getString('username') ?? '';
    String userAvatar = pref.getString('useravatar') ?? '';

    int timeStamp = DateTime.now().millisecondsSinceEpoch;
    String chatId = '$myUserId-$timeStamp';
    db.collection('personchat').doc(widget.chatRoomId).update({
      chatId: {
        'content': _inputcontroller.text,
        'userid': myUserId,
        'name': userName,
        'avatar': userAvatar,
        'timestamp': timeStamp
      }
    });
  }

  void scrollDownOnChat() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCirc);
  }

  void checkScroolBottom() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      setState(() {
        reachBottom = true;
      });
    } else {
      setState(() {
        reachBottom = false;
      });
    }
  }

  Future<XFile?> compressAndGetFile(File file, String targetPath) async {
    result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 80,
      rotate: 0,
    );
    setState(() {
      result;
    });
    return result;
  }

  void pickerAndCoverToBase64() async {
    final ImagePicker picker = ImagePicker();
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    final String targetPath =
        "$path/${DateTime.now().millisecondsSinceEpoch}.jpg";

    image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      image;
    });
    if (image != null) {
      await compressAndGetFile(File(image!.path), targetPath);
      List<int> imageBytes = await result!.readAsBytes();
      String base64Image = base64Encode(imageBytes);
      setState(() {
        base64Image;
      });
      print(base64Image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leadingWidth: 300,
            backgroundColor: Colors.white,
            leading: Row(
              children: [
                IconButton(
                  splashRadius: 20,
                  splashColor: Colors.white10,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.black,
                  ),
                ),
                AvatarGlow(
                  showTwoGlows: true,
                  endRadius: 25,
                  glowColor: Colors.red,
                  child: Material(
                      elevation: 2,
                      shape: const CircleBorder(),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.grey,
                        backgroundImage: NetworkImage(widget.partnerAvatar),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.partnerName,
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ],
                  ),
                )
              ],
            )),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
                child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Scaffold(
                  floatingActionButton: !reachBottom
                      ? IconButton(
                          splashRadius: 20,
                          icon: const Icon(
                            Icons.arrow_downward,
                            size: 20,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            scrollDownOnChat();
                          },
                        )
                      : null,
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.miniStartDocked,
                  backgroundColor: Colors.grey.shade200,
                  body: ListView.builder(
                    controller: _scrollController,
                    itemCount: chatMessageList.length,
                    itemBuilder: (context, index) {
                      final ChatMessage message = chatMessageList[index];
                      return Message(
                        message: message,
                      );
                    },
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  height: hasNewMessage ? 30 : 0,
                  child: GestureDetector(
                    onTap: () {
                      scrollDownOnChat();
                      setState(() {
                        hasNewMessage = false;
                      });
                    },
                    child: const Text(
                      'Có tin nhắn mới',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
              ],
            )),
            image != null && base64Image != null
                ? SizedBox(
                    height: 300,
                    width: 200,
                    child: Image.memory(
                      base64Decode(base64Image!),
                      fit: BoxFit.fitHeight,
                    ),
                  )
                : const SizedBox.shrink(),
            Container(
                //Chat input
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.08),
                      blurRadius: 32,
                      offset: const Offset(0, 4))
                ]),
                child: Row(children: [
                  IconButton(
                    onPressed: () async {
                      pickerAndCoverToBase64();
                    },
                    icon: const Icon(
                      Icons.image_outlined,
                      color: Colors.black,
                      size: 25,
                    ),
                  ),
                  // const Icon(
                  //   Icons.mic_none_outlined,
                  //   color: Colors.black,
                  //   size: 25,
                  // ),
                  // const SizedBox(
                  //   width: 10,
                  // ),
                  Expanded(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.black12),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          controller: _inputcontroller,
                          decoration: const InputDecoration(
                              hintText: 'Nhập nội dung...',
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () async {
                      await sendChat();
                      scrollDownOnChat();
                      _inputcontroller.clear();
                    },
                    child: const Icon(
                      Icons.send_outlined,
                      color: Colors.black,
                      size: 25,
                    ),
                  )
                ])),
          ],
        ));
  }
}
