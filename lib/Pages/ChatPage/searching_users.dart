import 'package:avatar_glow/avatar_glow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myjobapp/Classes/component/list_users_search.dart';
import 'package:myjobapp/Pages/ChatPage/chat_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchingUserPage extends StatefulWidget {
  const SearchingUserPage({
    super.key,
    required this.userData,
    this.oldChatroomID,
  });
  final List<UserForSearch> userData;
  final String? oldChatroomID;

  @override
  State<SearchingUserPage> createState() => _SearchingUserPageState();
}

class _SearchingUserPageState extends State<SearchingUserPage> {
  final TextEditingController _searchController = TextEditingController();
  FirebaseFirestore db = FirebaseFirestore.instance;
  bool tickCheckbox = false;
  List<String> listIdAdded = [];
  List<UserForSearch> filteredList = [];
  List<String> avatarList = [];

  @override
  void initState() {
    super.initState();
    if (widget.oldChatroomID != null) {
      listIdAdded = widget.oldChatroomID!.split('-');
      getAvatarList();
    } else {}
  }

  void getAvatarList() {
    for (String id in listIdAdded) {
      UserForSearch user =
          widget.userData.firstWhere((element) => element.id == id);
      avatarList.add(user.avatar);
    }
  }

  void generateChatRoomId(List<String> listidadded) async {
    List<String> listId = listidadded;
    listId.sort();
    String newChatRoomId = listId.join('-');
    await db
        .collection('personchat')
        .doc(newChatRoomId)
        .set({}, SetOptions(merge: true));
    if (widget.oldChatroomID != null) {
      DocumentSnapshot docSnapshot =
          await db.collection('personchat').doc(widget.oldChatroomID).get();
      dynamic oldDocData = docSnapshot.data() ?? {};
      await db
          .collection('personchat')
          .doc(newChatRoomId)
          .set(oldDocData, SetOptions(merge: true));
      await db.collection('personchat').doc(widget.oldChatroomID).delete();
    }
  }

  void searchFilter(String idsearch) {
    setState(() {
      if (idsearch.isEmpty) {
        filteredList.clear();
        if (listIdAdded.isNotEmpty) {
          for (String userId in listIdAdded) {
            UserForSearch? user =
                widget.userData.firstWhere((element) => element.id == userId);
            if (filteredList.contains(user)) {
              filteredList;
            } else {
              filteredList.add(user);
            }
          }
        } else {
          filteredList = [];
        }
      } else {
        filteredList = widget.userData
            .where((user) =>
                user.id.toLowerCase().contains(idsearch.toLowerCase()))
            .toList();
      }
    });
  }

  Future<void> welcomeChat() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String myUserId = pref.getString('userid') ?? '';
    String userName = pref.getString('username') ?? '';
    String userAvatar = pref.getString('useravatar') ?? '';

    int timeStamp = DateTime.now().millisecondsSinceEpoch;
    String chatId = '$myUserId-$timeStamp';
    String newChatRoomId = listIdAdded.join('-');
    db.collection('personchat').doc(newChatRoomId).update({
      chatId: {
        'content': widget.oldChatroomID != null
            ? 'Vừa thêm thành viên mới'
            : 'Nhóm vừa được tạo, chào mừng tất cả thành viên!',
        'userid': myUserId,
        'name': userName,
        'avatar': userAvatar,
        'timestamp': timeStamp,
        'messageType': 'text',
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          if (listIdAdded.isNotEmpty) {
            SharedPreferences pref = await SharedPreferences.getInstance();
            String myUserId = pref.getString('userid') ?? '';
            if (widget.oldChatroomID != null) {
              generateChatRoomId(listIdAdded);
              welcomeChat();
            } else {
              listIdAdded.add(myUserId);
              generateChatRoomId(listIdAdded);
              welcomeChat();
            }
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => ChatPage()));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              width: 200,
              clipBehavior: Clip.hardEdge,
              content: Text('Chưa chọn người để Chat !'),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ));
          }
        },
        label: const Text('Chat Nào!'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: TextFormField(
              onChanged: (e) => searchFilter(e),
              controller: _searchController,
              textAlignVertical: TextAlignVertical.center,
              decoration: const InputDecoration(
                labelText: 'Tìm kiếm...',
                prefixIcon: Icon(Icons.search),
                prefixIconColor: Colors.grey,
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(
            height: 70,
            width: double.infinity,
            child: ListView.builder(
                itemCount: listIdAdded.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.5),
                    child: AvatarGlow(
                      showTwoGlows: true,
                      repeat: true,
                      endRadius: 25,
                      glowColor: Colors.red.shade100,
                      child: Material(
                          elevation: 6,
                          shape: const CircleBorder(),
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.grey,
                            backgroundImage: NetworkImage(avatarList[index]),
                          )),
                    ),
                  );
                }),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 30, bottom: 5, top: 5),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        AvatarGlow(
                          showTwoGlows: true,
                          glowColor: Colors.blueAccent,
                          endRadius: 30,
                          child: CircleAvatar(
                            radius: 25,
                            backgroundImage:
                                NetworkImage(filteredList[index].avatar),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(filteredList[index].fullname == ''
                                  ? filteredList[index].companyname
                                  : filteredList[index].fullname)
                            ],
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            if (!listIdAdded.contains(filteredList[index].id)) {
                              listIdAdded.add(filteredList[index].id);
                              avatarList.add(filteredList[index].avatar);
                              setState(() {
                                tickCheckbox = true;
                              });
                            } else {
                              listIdAdded.remove(filteredList[index].id);
                              avatarList.remove(filteredList[index].avatar);
                              setState(() {
                                tickCheckbox = false;
                              });
                            }
                            setState(() {
                              listIdAdded;
                              avatarList;
                            });
                            print(listIdAdded);
                            print(avatarList);
                          },
                          child: Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.black12)),
                            child: listIdAdded.contains(filteredList[index].id)
                                ? const Icon(
                                    Icons.done,
                                    size: 15,
                                    color: Colors.black,
                                  )
                                : null,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      )),
    );
  }
}
