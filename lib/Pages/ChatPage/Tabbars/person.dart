import 'dart:convert';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:myjobapp/Classes/chat_class.dart';
import 'package:myjobapp/Classes/component/one_user_info.dart';
import 'package:myjobapp/Classes/person_chat_class.dart';
import 'package:myjobapp/Pages/ChatPage/chat_detail_person.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myjobapp/Pages/ChatPage/searching_users.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ChatTbPerson extends StatefulWidget {
  const ChatTbPerson({super.key});

  @override
  State<ChatTbPerson> createState() => _ChatTbPersonState();
}

class _ChatTbPersonState extends State<ChatTbPerson> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<PersonChatClass> personChatList = [];
  String timestampFormatted = '';
  OneUserInfo partnerInfo = OneUserInfo(
      id: '',
      avatar:
          'https://t4.ftcdn.net/jpg/05/49/98/39/360_F_549983970_bRCkYfk0P6PP5fKbMhZMIb07mCJ6esXL.jpg',
      companyname: '',
      phone: '',
      fullname: '');

  void generateChatRoomId(String userId1, String userId2) async {
    List<String> listId = [userId1, userId2];
    listId.sort();
    String newChatRoomId = listId.join('-');
    await db.collection('personchat').doc(newChatRoomId).set({});
  }

  dynamic splitChatRoomId(String chatRoomid) {
    List<String> listId = chatRoomid.split('-');
    return {'userId1': listId[0], 'userId2': listId[1]};
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
          dynamic userIds = splitChatRoomId(element.id);
          return myUserId == userIds['userId1'] ||
              myUserId == userIds['userId2'];
        },
      ).toList();

      List<PersonChatClass> personChatList2 = [];

      filterList.forEach((element) async {
        List<ChatMessage> listChat = element
            .data()
            .entries
            .map((e) => ChatMessage(
                text: e.value['content'],
                messageType: ChatMessageType.text,
                timestamp: e.value['timestamp'],
                name: e.value['name'],
                messageStatus: MessageStatus.viewed,
                avatar: e.value['avatar'],
                isSender: e.value['userid'] == myUserId))
            .toList();

        List<String> roomId = element.id.split('-');
        String partnerId = roomId.firstWhere((data) => data != myUserId);
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
        if (listChat.length == 0) {
          return;
        } else if (listChat.length == 1) {
          ChatMessage lastchatmessage = listChat[0];

          personChatList2.add(PersonChatClass(
              chatroomid: element.id,
              avatar: partnerInfo.avatar,
              name: partnerInfo.fullname == ''
                  ? partnerInfo.companyname
                  : partnerInfo.fullname,
              lastmessage: lastchatmessage.text,
              timestamp: lastchatmessage.timestamp));
        } else {
          ChatMessage lastchatmessage =
              listChat.reduce((a, b) => a.timestamp > b.timestamp ? a : b);

          personChatList2.add(PersonChatClass(
              chatroomid: element.id,
              avatar: partnerInfo.avatar,
              name: partnerInfo.fullname == ''
                  ? partnerInfo.companyname
                  : partnerInfo.fullname,
              lastmessage: lastchatmessage.text,
              timestamp: lastchatmessage.timestamp));
        }
      });
      if (mounted) {
        setState(() {
          personChatList = personChatList2;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getChat();
  }

  @override
  Widget build(BuildContext context) {
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
                              builder: (context) => SearchingUserPage()));
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
                                  'Tìm kiếm...',
                                  style: TextStyle(color: Colors.grey),
                                )
                              ]),
                        ),
                      ),
                      IconButton(
                        iconSize: 30,
                        splashRadius: 23,
                        icon: const Icon(Icons.group_add),
                        onPressed: () {
                          generateChatRoomId('4444', '1111');
                        },
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 120,
                  width: double.infinity,
                  child: ListView.builder(
                      itemCount: 7,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.5),
                          child: AvatarGlow(
                            showTwoGlows: true,
                            repeat: true,
                            endRadius: 45,
                            glowColor: Colors.red,
                            child: Material(
                                elevation: 8,
                                shape: CircleBorder(),
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.grey,
                                  backgroundImage: NetworkImage(
                                      'https://keomoi.com/wp-content/uploads/2019/05/anh-gai-xinh-nhat-ban-2019-hinh-6.jpg'),
                                )),
                          ),
                        );
                      }),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 600,
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: personChatList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
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
                                              chatRoomId: personChatList[index]
                                                  .chatroomid,
                                              partnerAvatar:
                                                  personChatList[index].avatar,
                                              partnerName:
                                                  personChatList[index].name,
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
                                            personChatList[index].lastmessage,
                                            overflow: TextOverflow.ellipsis,
                                            style:
                                                const TextStyle(fontSize: 14),
                                          ),
                                        ],
                                      )),
                                  Expanded(
                                      child: Align(
                                          child: Text(timestampToDate(
                                              personChatList[index]
                                                  .timestamp))))
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
  }
}
