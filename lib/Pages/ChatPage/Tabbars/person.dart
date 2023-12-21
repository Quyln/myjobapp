import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:myjobapp/Classes/chat_class.dart';
import 'package:myjobapp/Classes/person_chat_class.dart';
import 'package:myjobapp/Pages/ChatPage/chat_detail_person.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myjobapp/Pages/ChatPage/searching_users.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatTbPerson extends StatefulWidget {
  const ChatTbPerson({super.key});

  @override
  State<ChatTbPerson> createState() => _ChatTbPersonState();
}

class _ChatTbPersonState extends State<ChatTbPerson> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<PersonChatClass> personChatList = [];

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
      print(filterList[0].data());
      List<PersonChatClass> personChatList2 = [];
      filterList.forEach((element) {
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
        if (listChat.length == 0) {
          return;
        } else if (listChat.length == 1) {
          ChatMessage lastchatmessage = listChat[0];
          personChatList2.add(PersonChatClass(
              chatroomid: element.id,
              avatar: lastchatmessage.avatar,
              name: '123',
              lastmessage: lastchatmessage.text,
              timestamp: lastchatmessage.timestamp));
        } else {
          ChatMessage lastMessage =
              listChat.reduce((a, b) => a.timestamp > b.timestamp ? a : b);
          // làm api lấy user theo id, lấy avatar và name bỏ xuống dưới
          personChatList2.add(PersonChatClass(
              chatroomid: element.id,
              avatar: lastMessage.avatar,
              name: '123',
              lastmessage: lastMessage.text,
              timestamp: lastMessage.timestamp));
        }
      });
      setState(() {
        personChatList = personChatList2;
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: CustomScrollView(
        slivers: [
          // SliverAppBar(
          //   pinned: true,
          //   backgroundColor: Colors.white,
          //   leading: const Padding(
          //     padding: EdgeInsets.only(left: 10),
          //     child: Icon(
          //       Icons.arrow_back_ios_new,
          //       color: Colors.grey,
          //     ),
          //   ),
          //   title: const Center(
          //     child: Text(
          //       'GIẢI TRÍ',
          //       style: TextStyle(
          //           color: Colors.black,
          //           fontWeight: FontWeight.bold,
          //           fontSize: 18),
          //     ),
          //   ),
          //   actions: [
          //     Padding(
          //       padding: const EdgeInsets.only(right: 10),
          //       child: IconButton(
          //           onPressed: () {},
          //           icon: const Icon(
          //             Icons.add,
          //             color: Colors.grey,
          //             size: 30,
          //           )),
          //     )
          //   ],
          // ),
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
                        icon: Icon(Icons.group_add),
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
                                            )));
                              },
                              child: SizedBox(
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
                                              color: Colors.black),
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
                                      width: 220,
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
                                          child: Text(
                                              '${personChatList[index].timestamp}')))
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
