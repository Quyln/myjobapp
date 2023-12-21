import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailPersonChatPage extends StatefulWidget {
  const DetailPersonChatPage({super.key, required this.chatRoomId});
  final String chatRoomId;

  @override
  State<DetailPersonChatPage> createState() => _DetailPersonChatPageState();
}

class _DetailPersonChatPageState extends State<DetailPersonChatPage> {
  FirebaseFirestore db = FirebaseFirestore.instance;

  void getChat() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String myUserId = pref.getString('userid') ?? '';
    // doan nay la de lang nghe Firebase
    final docRef = db.collection("test").doc(widget.chatRoomId);
    docRef.snapshots().listen(
      (event) {
        print(event.data());
      },
      onError: (error) => print("Listen failed: $error"),
    );
  }

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
            // Expanded(
            //     child: ListView.builder(
            //   itemCount: demoChatMessage.length,
            //   itemBuilder: (context, index) {
            //     final ChatMessage message = demoChatMessage[index];
            //     return Message(message: message);
            //   },
            // )),
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
