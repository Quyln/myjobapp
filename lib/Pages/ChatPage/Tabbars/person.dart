import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:myjobapp/Classes/chat_class.dart';
import 'package:myjobapp/Classes/component/one_user_info.dart';
import 'package:myjobapp/Classes/person_chat_class.dart';
import 'package:myjobapp/Pages/ChatPage/chat_detail_person.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myjobapp/Pages/ChatPage/searching_users.dart';
import 'package:myjobapp/Provider/get_users_filter_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../Classes/component/list_users_search.dart';

class ChatTbPerson extends StatefulWidget {
  const ChatTbPerson({super.key, required this.usersData});
  final List<UserForSearch> usersData;

  @override
  State<ChatTbPerson> createState() => _ChatTbPersonState();
}

class _ChatTbPersonState extends State<ChatTbPerson> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<PersonChatClass> personChatList = [];
  List<UserForSearch> roomNameListByIdList = [];
  String roomName = '';
  String timestampFormatted = '';
  OneUserInfo partnerInfo = OneUserInfo(
      id: '',
      avatar:
          'https://t4.ftcdn.net/jpg/05/49/98/39/360_F_549983970_bRCkYfk0P6PP5fKbMhZMIb07mCJ6esXL.jpg',
      companyname: '',
      fullname: '');

  Map<String, dynamic> splitChatRoomId(String chatRoomid) {
    List<String> listId = chatRoomid.split('-');
    Map<String, dynamic> result = {};
    for (int i = 0; i < listId.length; i++) {
      String key = 'userId${i + 1}';
      result[key] = listId[i];
    }
    return result;
  }

  String timestampToDate(int timestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    DateTime now = DateTime.now();

    if (dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day) {
      Duration difference = now.difference(dateTime);
      if (difference.inSeconds < 60) {
        return 'vài giây trước';
      } else if (difference.inMinutes < 60) {
        return '${difference.inMinutes} phút trước';
      } else {
        return '${difference.inHours} giờ trước';
      }
    } else {
      DateFormat dateFormat = DateFormat('dd/MM/yyyy');
      return dateFormat.format(dateTime);
    }
  }

  void getChat() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String myUserId = pref.getString('userid') ?? '';

    final docRef = db.collection("personchat");
    docRef.snapshots().listen((event) {
      List<QueryDocumentSnapshot<Map<String, dynamic>>> filterList =
          event.docs.where(
        (element) {
          Map<String, dynamic> userIds = splitChatRoomId(element.id);
          return userIds.containsValue(myUserId);
        },
      ).toList();

      List<PersonChatClass> personChatList2 = [];

      filterList.forEach((element) async {
        List<ChatMessage> listChat = element
            .data()
            .entries
            .map((e) => ChatMessage(
                text: e.value['content'],
                messageType: e.value['messageType'],
                timestamp: e.value['timestamp'],
                name: e.value['name'],
                messageStatus: MessageStatus.viewed,
                avatar: e.value['avatar'],
                isSender: e.value['userid'] == myUserId))
            .toList();

        List<String> roomIdList = element.id.split('-');

        for (String id in roomIdList) {
          UserForSearch user =
              widget.usersData.firstWhere((element) => element.id == id);
          roomNameListByIdList.add(user);
        }
        List<String> takeUserFullname = roomNameListByIdList
            .map((user) => user.fullname)
            .where((fullname) => fullname != '')
            .toList();
        List<String> takeUserComName = roomNameListByIdList
            .map((user) => user.companyname)
            .where((fullname) => fullname != '')
            .toList();
        List<String> finalRoomName = takeUserComName + takeUserFullname;
        finalRoomName.sort();
        roomName = finalRoomName.join(',');

        String partnerId = roomIdList.firstWhere((data) => data != myUserId);

        var url = Uri.parse('http://103.176.251.70:100/users/takeoneuser');
        var respone = await http.post(url, body: {"userid": partnerId});

        if (respone.statusCode == 201) {
          Map<String, dynamic> data = jsonDecode(respone.body);
          partnerInfo = OneUserInfo.fromJson(data);
          if (mounted) {
            setState(() {
              partnerInfo;
            });
          }
        }
        if (listChat.isEmpty) {
        } else if (listChat.length == 1) {
          ChatMessage lastchatmessage = listChat[0];

          personChatList2.add(PersonChatClass(
              chatroomid: element.id,
              avatar: roomIdList.length < 3
                  ? partnerInfo.avatar
                  : 'https://img.freepik.com/premium-vector/businesspeople-character-avatar-icon_24877-18272.jpg',
              name: roomIdList.length < 3
                  ? '${partnerInfo.companyname}${partnerInfo.fullname}'
                  : element.id,
              lastmessage: lastchatmessage.text,
              timestamp: lastchatmessage.timestamp));
        } else {
          ChatMessage lastchatmessage =
              listChat.reduce((a, b) => a.timestamp > b.timestamp ? a : b);

          personChatList2.add(PersonChatClass(
              chatroomid: element.id,
              avatar: roomIdList.length < 3
                  ? partnerInfo.avatar
                  : 'https://img.freepik.com/premium-vector/businesspeople-character-avatar-icon_24877-18272.jpg',
              name: roomIdList.length < 3
                  ? '${partnerInfo.companyname}${partnerInfo.fullname}'
                  : element.id,
              lastmessage: lastchatmessage.text == ''
                  ? 'Hình ảnh'
                  : lastchatmessage.text,
              timestamp: lastchatmessage.timestamp));
        }
        if (mounted) {
          setState(() {
            personChatList = personChatList2;
            personChatList.sort((a, b) => b.timestamp.compareTo(a.timestamp));
          });
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getChat();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FilterUserSearchPro>(
      builder: (context, value, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
              child: CustomScrollView(
            slivers: [
              SliverList(
                  delegate: SliverChildListDelegate([
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SearchingUserPage(
                                        userData: value.listUsers,
                                      )));
                            },
                            child: Container(
                              height: 50,
                              width: 300,
                              decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.search,
                                      color: Colors.grey,
                                    ),
                                    Text(
                                      'Tìm và Chat',
                                      style: TextStyle(color: Colors.grey),
                                    )
                                  ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 600,
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: personChatList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Slidable(
                                endActionPane: ActionPane(
                                  motion: const StretchMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (context) {},
                                      icon: Icons.call,
                                      backgroundColor: Colors.green,
                                    ),
                                    SlidableAction(
                                      onPressed: (context) {},
                                      icon: Icons.video_call_sharp,
                                      backgroundColor: Colors.blue,
                                    ),
                                    SlidableAction(
                                      onPressed: (context) {},
                                      icon: Icons.delete,
                                      backgroundColor: Colors.red,
                                    ),
                                  ],
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DetailPersonChatPage(
                                                  usersData: value.listUsers,
                                                  chatRoomId:
                                                      personChatList[index]
                                                          .chatroomid,
                                                  partnerAvatar:
                                                      personChatList[index]
                                                          .avatar,
                                                  partnerName:
                                                      personChatList[index]
                                                          .name,
                                                )));
                                  },
                                  child: Container(
                                    color: Colors.transparent,
                                    height: 80,
                                    width: double.infinity,
                                    child: Row(children: [
                                      Stack(
                                        children: [
                                          Container(
                                              height: 60,
                                              width: 60,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                child: Image.network(
                                                  personChatList[index].avatar,
                                                  fit: BoxFit.cover,
                                                ),
                                              )),
                                          Positioned(
                                            right: 2,
                                            bottom: 3,
                                            child: Container(
                                              height: 10,
                                              width: 10,
                                              decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      width: 3,
                                                      color: Colors.white,
                                                      strokeAlign: BorderSide
                                                          .strokeAlignOutside)),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      SizedBox(
                                          width: 210,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                personChatList[index].name,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                personChatList[index]
                                                    .lastmessage,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontSize: 14),
                                              ),
                                            ],
                                          )),
                                      Expanded(
                                          child: Align(
                                              child: Text(timestampToDate(
                                                  personChatList[index]
                                                      .timestamp)))),
                                    ]),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ]))
            ],
          )),
        );
      },
    );
  }
}
