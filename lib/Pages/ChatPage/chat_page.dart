import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool statusborder = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.grey,
        ),
        title: const Center(
          child: Text(
            'GIẢI TRÍ',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.add,
                color: Colors.grey,
                size: 30,
              ))
        ],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                height: 50,
                width: 350,
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
                                        borderRadius: BorderRadius.circular(25),
                                        color: Colors.black),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(25),
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
                                            strokeAlign:
                                                BorderSide.strokeAlignOutside)),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                            const Expanded(child: Text('12:30'))
                          ]),
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
      )),
    );
  }
}
