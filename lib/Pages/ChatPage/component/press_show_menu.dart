import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myjobapp/Classes/component/list_users_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Classes/component/more_menu_class.dart';
import '../../../bottombar_nav.dart';

// ignore: must_be_immutable
class BuildLongPressMenu extends StatefulWidget {
  const BuildLongPressMenu({super.key, required this.userData});
  final UserForSearch userData;

  @override
  State<BuildLongPressMenu> createState() => _BuildLongPressMenuState();
}

class _BuildLongPressMenuState extends State<BuildLongPressMenu> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<ItemModel> menuItems = [
    ItemModel('Nhắn tin', Icons.send),
  ];

  void generateChatRoomId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? myUserId = pref.getString('userid');
    String userName = pref.getString('username') ?? '';
    String userAvatar = pref.getString('useravatar') ?? '';

    List<String> listId = [myUserId!, widget.userData.id];
    listId.sort();
    int timeStamp = DateTime.now().millisecondsSinceEpoch;
    String chatId = '$myUserId-$timeStamp';
    String newChatRoomId = listId.join('-');
    await db.collection('personchat').doc(newChatRoomId).set({
      chatId: {
        'content': 'Hi',
        'userid': myUserId,
        'name': userName,
        'avatar': userAvatar,
        'timestamp': timeStamp,
        'messageType': 'text',
      }
    }, SetOptions(merge: true));
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
        height: 55,
        width: 70,
        color: const Color(0xFF4C4C4C),
        child: GridView.count(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          crossAxisCount: 1,
          crossAxisSpacing: 0,
          mainAxisSpacing: 10,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: menuItems
              .map((item) => GestureDetector(
                    onTap: () {
                      if (item.title == 'Nhắn tin') {
                        generateChatRoomId();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BottomBarNav(
                                      pageindex: 3,
                                    )));
                      }
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          item.icon,
                          size: 20,
                          color: Colors.white,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 2),
                          child: Text(
                            item.title,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
