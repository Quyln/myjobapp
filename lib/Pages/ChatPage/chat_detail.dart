import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:myjobapp/Classes/chat_class.dart';
import 'package:myjobapp/utils/colors_texts_style.dart';

class DetailChatPage extends StatefulWidget {
  const DetailChatPage({super.key});

  @override
  State<DetailChatPage> createState() => _DetailChatPageState();
}

class _DetailChatPageState extends State<DetailChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leadingWidth: 300,
          backgroundColor: Colors.white,
          leading: Padding(
            padding: const EdgeInsets.only(
              left: 20,
            ),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.black,
                  ),
                ),
                const AvatarGlow(
                  showTwoGlows: true,
                  endRadius: 25,
                  glowColor: Colors.red,
                  child: Material(
                      elevation: 2,
                      shape: CircleBorder(),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.grey,
                        backgroundImage: NetworkImage(
                            'https://keomoi.com/wp-content/uploads/2019/05/anh-gai-xinh-nhat-ban-2019-hinh-6.jpg'),
                      )),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Khả Như',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      Text(
                        '+84 983 456 789',
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.normal,
                            fontSize: 14),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          actions: const [
            Icon(
              Icons.call,
              color: Colors.black,
            ),
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.video_call,
              color: Colors.black,
            ),
            SizedBox(
              width: 20,
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
                child: ListView.builder(
              itemCount: demoChatMessage.length,
              itemBuilder: (context, index) {
                final ChatMessage message = demoChatMessage[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: message.isSender
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                      if (!message.isSender) ...[
                        const CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.grey,
                          backgroundImage: NetworkImage(
                              'https://keomoi.com/wp-content/uploads/2019/05/anh-gai-xinh-nhat-ban-2019-hinh-6.jpg'),
                        )
                      ],
                      Container(
                          decoration: BoxDecoration(
                              color: message.isSender
                                  ? Colors.green
                                  : Colors.black45,
                              borderRadius: BorderRadius.circular(30)),
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: Text(
                            demoChatMessage[index].text,
                            style: TextStyle(color: Colors.white),
                          )),
                    ],
                  ),
                );
              },
            )),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.08),
                        blurRadius: 32,
                        offset: const Offset(0, 4))
                  ]),
              child: SafeArea(
                child: Row(children: [
                  const Icon(
                    Icons.image_outlined,
                    color: Colors.black,
                    size: 25,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Icon(
                    Icons.mic_none_outlined,
                    color: Colors.black,
                    size: 25,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.black12),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: 'Nhập nội dung...',
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Icon(
                    Icons.send_outlined,
                    color: Colors.black,
                    size: 25,
                  )
                ]),
              ),
            ),
          ],
        ));
  }
}
