import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:myjobapp/Pages/ChatPage/chat_detail_regional.dart';
import 'package:myjobapp/utils/list_tinh_huyen_cv.dart';

class ChatTbRegional extends StatelessWidget {
  const ChatTbRegional({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/covietnam2.gif',
                width: 40,
                height: 40,
              ),
              const Text(
                'Cộng Đồng Tỉnh Thành',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              Image.asset(
                'images/covietnam2.gif',
                width: 40,
                height: 40,
              ),
            ],
          )),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(bottom: 60, top: 10),
        child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemCount: listKvTinh.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailRegionalChatPage(
                                kvTinh: listKvTinh[index]['name']!,
                                kvTinhId: listKvTinh[index]['id']!,
                                kvTinhImage: listKvTinh[index]['image']!,
                              )));
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Column(
                    children: [
                      AvatarGlow(
                        showTwoGlows: true,
                        endRadius: 34,
                        glowColor: const Color.fromARGB(255, 242, 16, 0),
                        child: Material(
                            elevation: 8,
                            shape: const CircleBorder(),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.grey,
                              backgroundImage:
                                  AssetImage(listKvTinh[index]['image']!),
                            )),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        listKvTinh[index]['name']!,
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 13),
                      )
                    ],
                  ),
                ),
              ),
            )),
      )),
    );
  }
}
