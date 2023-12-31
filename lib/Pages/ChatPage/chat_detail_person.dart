import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:cached_memory_image/cached_memory_image.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myjobapp/Classes/component/list_users_info.dart';
import 'package:myjobapp/Classes/component/more_menu_class.dart';
import 'package:myjobapp/Pages/ChatPage/component/PersonGroup/person_message.dart';
import 'package:myjobapp/Pages/ChatPage/searching_users.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import '../../Classes/chat_class.dart';
import '../../Provider/get_users_filter_provider.dart';
import '../../bottombar_nav.dart';

class DetailPersonChatPage extends StatefulWidget {
  const DetailPersonChatPage(
      {super.key,
      required this.chatRoomId,
      required this.partnerAvatar,
      required this.usersData,
      required this.partnerName});
  final String chatRoomId;
  final String partnerAvatar;
  final String partnerName;
  final List<UserForSearch> usersData;

  @override
  State<DetailPersonChatPage> createState() => _DetailPersonChatPageState();
}

class _DetailPersonChatPageState extends State<DetailPersonChatPage> {
  ScrollController _scrollController = ScrollController();
  TextEditingController _inputcontroller = TextEditingController();

  List<ChatMessage> chatMessageList = [];
  List<ChatMessage> latestChatMessages = [];
  List<UserForSearch> roomNameListByIdList = [];
  List<String> chatRoomIdList = [];

  FirebaseFirestore db = FirebaseFirestore.instance;
  String? quoteChatMessage;
  bool isQuoting = false;
  bool hasNewMessage = false;
  String roomId = '';
  bool reachBottom = false;
  bool showGallery = false;
  String roomName = '';
  XFile? image;
  XFile? result;
  String? base64Image;
  CustomPopupMenuController _popupMenuController = CustomPopupMenuController();
  List<ItemModel> menuItems = [
    ItemModel('Thêm thành viên', Icons.add),
    ItemModel('Thoát nhóm', Icons.subdirectory_arrow_left),
  ];
  AssetEntity? choicedImage;
  @override
  void initState() {
    super.initState();
    getChat();
    getRoomName();
    chatRoomIdList = widget.chatRoomId.split('-');
    // _scrollController.addListener(checkScroolBottom);
  }

  void getRoomName() {
    List<String> roomIdList = widget.chatRoomId.split('-');
    for (String id in roomIdList) {
      UserForSearch user =
          widget.usersData.firstWhere((element) => element.id == id);
      roomNameListByIdList.add(user);
    }
    List<String> takeUserFullname = roomNameListByIdList
        .map((e) => e.fullname)
        .where((element) => element != '')
        .toList();
    List<String> takeUserComName = roomNameListByIdList
        .map((e) => e.companyname)
        .where((element) => element != '')
        .toList();
    List<String> finalRoomName = takeUserComName + takeUserFullname;
    finalRoomName.sort();
    roomName = finalRoomName.join(',');
  }

  void outGroup(String currentRoomId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String myUserId = pref.getString('userid') ?? '';
    List<String> listId = currentRoomId.split('-');
    List<String> listIdNoUserId =
        listId.where((element) => element != myUserId).toList();
    listIdNoUserId.sort();
    String newChatRoomId = listIdNoUserId.join('-');
    await db
        .collection('personchat')
        .doc(newChatRoomId)
        .set({}, SetOptions(merge: true));

    DocumentSnapshot docSnapshot =
        await db.collection('personchat').doc(widget.chatRoomId).get();
    dynamic oldDocData = docSnapshot.data() ?? {};
    await db
        .collection('personchat')
        .doc(newChatRoomId)
        .set(oldDocData, SetOptions(merge: true));
    await db.collection('personchat').doc(widget.chatRoomId).delete();
  }

  void getChat() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String myUserId = pref.getString('userid') ?? '';
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
                    messageType: e.value['messageType'],
                    timestamp: e.value['timestamp'],
                    name: e.value['name'],
                    messageStatus: MessageStatus.viewed,
                    avatar: e.value['avatar'],
                    imageb64: e.value['imageb64'],
                    isSender: e.value['userid'] == myUserId))
                .toList() ??
            [];
        if (mounted) {
          setState(() {
            chatMessageList.sort((a, b) {
              return a.timestamp.compareTo(b.timestamp);
            });
          });
        }

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
        'timestamp': timeStamp,
        'messageType': 'text',
      }
    });
  }

  Future<void> sendImage() async {
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
        'timestamp': timeStamp,
        'messageType': 'image',
        'imageb64': base64Image
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
      quality: 40,
      rotate: 0,
    );
    setState(() {
      result;
    });
    return result;
  }

  void pickerAndConvertToBase64() async {
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
      base64Image = base64Encode(imageBytes);
      setState(() {
        base64Image;
      });
      print(base64Image);
    }
  }

  void convertAssetEntityToBase64(AssetEntity assetEntity) async {
    final file = await assetEntity.file;
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    final String targetPath =
        "$path/${DateTime.now().millisecondsSinceEpoch}.jpg";
    if (file != null) {
      await compressAndGetFile(file, targetPath);
      final bytes = await result!.readAsBytes();
      base64Image = base64Encode(bytes);
      setState(() {
        base64Image;
      });
      sendImage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FilterUserSearchPro>(
      builder: (context, value, child) {
        return Scaffold(
            appBar: AppBar(
              leadingWidth: 89,
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
                      size: 20,
                    ),
                  ),
                  AvatarGlow(
                      showTwoGlows: true,
                      endRadius: 20,
                      glowColor: Colors.red,
                      child: ClipOval(
                        child: SizedBox(
                            height: 35,
                            width: 35,
                            child: CachedMemoryImage(
                              uniqueKey: widget.partnerAvatar,
                              base64: widget.partnerAvatar,
                              fit: BoxFit.cover,
                            )),
                      )),
                ],
              ),
              title: Text(
                roomNameListByIdList.length < 3 ? widget.partnerName : roomName,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              actions: [
                chatRoomIdList.length > 2
                    ? CustomPopupMenu(
                        menuBuilder: () => ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            color: const Color(0xFF4C4C4C),
                            child: IntrinsicWidth(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: menuItems
                                  .map((menu) => GestureDetector(
                                        behavior: HitTestBehavior.translucent,
                                        onTap: () {
                                          if (menu.title == 'Thêm thành viên') {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SearchingUserPage(
                                                          userData:
                                                              value.listUsers,
                                                          oldChatroomID:
                                                              widget.chatRoomId,
                                                        )));
                                          } else {
                                            outGroup(widget.chatRoomId);
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const BottomBarNav(
                                                          pageindex: 3,
                                                        )));
                                          }
                                          _popupMenuController.hideMenu();
                                        },
                                        child: Container(
                                          height: 40,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Row(
                                            children: [
                                              Icon(
                                                menu.icon,
                                                size: 15,
                                                color: Colors.white,
                                              ),
                                              Expanded(
                                                  child: Container(
                                                margin: const EdgeInsets.only(
                                                    left: 10),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10),
                                                child: Text(
                                                  menu.title,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ))
                                            ],
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            )),
                          ),
                        ),
                        pressType: PressType.singleClick,
                        controller: _popupMenuController,
                        verticalMargin: -10,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: const Icon(
                            Icons.more_vert,
                            color: Colors.black,
                          ),
                        ),
                      )
                    : const SizedBox.shrink()
              ],
            ),
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
                          return MessagePerson(
                            groupName: roomName,
                            partnerAvatar: widget.partnerAvatar,
                            roomIdList: roomNameListByIdList,
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.08),
                          blurRadius: 32,
                          offset: const Offset(0, 4))
                    ]),
                    child: Row(children: [
                      IconButton(
                        onPressed: () async {
                          // pickerAndConvertToBase64();
                          List<AssetEntity>? result = [];
                          result = await AssetPicker.pickAssets(
                            context,
                            pickerConfig: const AssetPickerConfig(
                                maxAssets: 1, requestType: RequestType.image),
                          );
                          if (result != null) {
                            choicedImage = result.first;
                            setState(() {
                              choicedImage;
                            });
                            convertAssetEntityToBase64(choicedImage!);
                          }
                        },
                        icon: const Icon(
                          Icons.image_outlined,
                          color: Colors.black,
                          size: 25,
                        ),
                      ),
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
                              onTap: () {},
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () async {
                          if (base64Image != null) {
                            await sendImage();
                          } else {
                            await sendChat();
                          }
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
      },
    );
  }
}
