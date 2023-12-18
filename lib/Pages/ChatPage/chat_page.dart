import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myjobapp/Pages/ChatPage/Tabbars/person.dart';
import 'package:myjobapp/Pages/ChatPage/Tabbars/regional.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // FirebaseFirestore db = FirebaseFirestore.instance;
  // void getChat() async {
  //   final docRef = db.collection("test").doc("chatdemo");
  //   docRef.snapshots().listen(
  //         (event) => print("current data: ${event.data()}"),
  //         onError: (error) => print("Listen failed: $error"),
  //       );
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   getChat();
  // }

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(children: [
            TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Colors.green,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(
                    icon: Icon(
                      Icons.person,
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.location_city,
                    ),
                  ),
                  // Tab(
                  //   icon: Icon(
                  //     Icons.group,
                  //   ),
                  // ),
                ]),
            Expanded(
              child: TabBarView(children: [
                ChatTbPerson(),
                ChatTbRegional(),
                // ChatTbGroup(),
              ]),
            )
          ]),
        ),
      ),
    );
  }
}
