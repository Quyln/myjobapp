import 'package:flutter/material.dart';
import 'package:myjobapp/Pages/ChatPage/Tabbars/person.dart';
import 'package:myjobapp/Pages/ChatPage/Tabbars/regional.dart';
import 'package:myjobapp/Provider/get_users_filter_provider.dart';
import 'package:provider/provider.dart';
import 'Tabbars/nearby_search.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FilterUserSearchPro>(
      builder: (context, value, child) {
        return DefaultTabController(
          length: 3,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Column(children: [
                const TabBar(
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: Colors.green,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(
                        text: 'Cá nhân',
                        icon: Icon(
                          Icons.group,
                        ),
                      ),
                      Tab(
                        text: 'Tìm quanh đây',
                        icon: Icon(
                          Icons.location_on,
                        ),
                      ),
                      Tab(
                        text: 'Khu vực',
                        icon: Icon(
                          Icons.location_city,
                        ),
                      ),
                    ]),
                Expanded(
                  child: TabBarView(children: [
                    ChatTbPerson(
                      usersData: value.listUsers,
                    ),
                    NearBySearchTabbar(
                      usersData: value.listUsers,
                    ),
                    const ChatTbRegional(),
                    // ChatTbGroup(),
                  ]),
                )
              ]),
            ),
          ),
        );
      },
    );
  }
}
