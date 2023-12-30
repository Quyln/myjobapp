import 'package:avatar_glow/avatar_glow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myjobapp/Classes/chat_class.dart';
import 'package:myjobapp/Pages/ChatPage/component/Regional/regional_message.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailRegionalChatPage extends StatefulWidget {
  const DetailRegionalChatPage(
      {super.key,
      required this.kvTinh,
      required this.kvTinhId,
      required this.kvTinhImage});
  final String kvTinh;
  final String kvTinhId;
  final String kvTinhImage;

  @override
  State<DetailRegionalChatPage> createState() => _DetailRegionalChatPageState();
}

class _DetailRegionalChatPageState extends State<DetailRegionalChatPage> {
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

  void getChat() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String myUserId = pref.getString('userid') ?? '';
    // doan nay la de lang nghe Firebase
    final docRef = db.collection("test").doc(widget.kvTinhId);
    docRef.snapshots().listen(
      (event) {
        if (roomId != widget.kvTinhId) {
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
                    messageType: 'text',
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
        roomId = widget.kvTinhId;
      },
      onError: (error) => print("Listen failed: $error"),
    );
  }

  void getQuoteChatMessage() {}

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
    db.collection('test').doc(widget.kvTinhId).update({
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

  @override
  void initState() {
    super.initState();
    getChat();
    // _scrollController.addListener(checkScroolBottom);
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
                        backgroundImage: AssetImage(widget.kvTinhImage),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Cộng đồng khu vực',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 14),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        widget.kvTinh,
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
                      return MessageSocial(
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
                      await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
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
