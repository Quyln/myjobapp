import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:myjobapp/Classes/chat_class.dart';
import 'package:myjobapp/Pages/ChatPage/message.dart';
import 'package:image_picker/image_picker.dart';

class DetailRegionalChatPage extends StatefulWidget {
  const DetailRegionalChatPage({super.key, required this.kvTinh});
  final String kvTinh;

  @override
  State<DetailRegionalChatPage> createState() => _DetailRegionalChatPageState();
}

class _DetailRegionalChatPageState extends State<DetailRegionalChatPage> {
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
                            'https://th.bing.com/th/id/R.7a64084ef8e328bd73ca5fe1fe5d8a24?rik=NzvRfVeFDPErog&pid=ImgRaw&r=0'),
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
            ),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: Align(
                child: Text(
                  "(5433/10000)",
                  style: TextStyle(color: Colors.black),
                ),
              ),
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
                return Message(message: message);
              },
            )),
            Container(
              //Chat input
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
