import 'package:flutter/material.dart';
import 'package:myjobapp/Pages/ChatPage/chat_detail_regional.dart';
import 'package:myjobapp/utils/list_tinh_huyen_cv.dart';

class ChatTbRegional extends StatelessWidget {
  const ChatTbRegional({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 3,
              ),
              itemCount: listKvTinh.length,
              itemBuilder: (context, index) => Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailRegionalChatPage(
                                    kvTinh: listKvTinh[index]['name']!,
                                    kvTinhId: listKvTinh[index]['id']!,
                                  )));
                    },
                    child: Container(
                      padding: const EdgeInsets.only(left: 10),
                      height: 30,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                            colors: [Colors.pink, Colors.purple],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                      ),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            listKvTinh[index]['name']!,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ),
                ],
              ),
            )),
      )),
    );
  }
}
