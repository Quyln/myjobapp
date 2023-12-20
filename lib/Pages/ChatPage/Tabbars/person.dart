import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:myjobapp/Pages/ChatPage/chat_detail_person.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatTbPerson extends StatefulWidget {
  const ChatTbPerson({super.key});

  @override
  State<ChatTbPerson> createState() => _ChatTbPersonState();
}

class _ChatTbPersonState extends State<ChatTbPerson> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  void generateChatRoomId(String userId1, String userId2) {
    List<String> listId = [userId1, userId2];
    listId.sort();
    String newChatRoomId = listId.join('-');
    final newChatRoom = db.collection('personchat').doc('$newChatRoomId');
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
                      Container(
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
                      InkWell(
                          onTap: () {},
                          child: IconButton(
                            iconSize: 30,
                            splashRadius: 23,
                            icon: Icon(Icons.group_add),
                            onPressed: () {},
                          )),
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
                      itemCount: 7,
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
                                            const DetailPersonChatPage()));
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
                                              'https://keomoi.com/wp-content/uploads/2019/05/anh-gai-xinh-nhat-ban-2019-hinh-6.jpg',
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
                                  const SizedBox(
                                      width: 220,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Khả Như',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            'Hẹn gặp lại nhé',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ],
                                      )),
                                  const Expanded(
                                      child: Align(child: Text('12:30')))
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
