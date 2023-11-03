import 'package:flutter/material.dart';
import 'package:myjobapp/Pages/ChatPage/Tabbars/group.dart';
import 'package:myjobapp/Pages/ChatPage/Tabbars/person.dart';
import 'package:myjobapp/Pages/ChatPage/Tabbars/regional.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 3,
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
                  Tab(
                    icon: Icon(
                      Icons.group,
                    ),
                  ),
                ]),
            Expanded(
              child: TabBarView(children: [
                ChatTbPerson(),
                ChatTbRegional(),
                ChatTbGroup(),
              ]),
            )
          ]),
        ),
      ),
    );
  }
}
