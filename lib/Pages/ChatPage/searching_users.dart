import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:myjobapp/Provider/get_users_filter_provider.dart';
import 'package:provider/provider.dart';

class SearchingUserPage extends StatefulWidget {
  const SearchingUserPage({super.key});

  @override
  State<SearchingUserPage> createState() => _SearchingUserPageState();
}

class _SearchingUserPageState extends State<SearchingUserPage> {
  TextEditingController _searchcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FilterUserSearchPro>(
      create: (context) {
        return FilterUserSearchPro();
      },
      child: Consumer<FilterUserSearchPro>(
        builder: (context, value, child) {
          return Scaffold(
            body: SafeArea(
                child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: TextFormField(
                    controller: _searchcontroller,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: const InputDecoration(
                      labelText: 'Tìm kiếm...',
                      prefixIcon: Icon(Icons.search),
                      prefixIconColor: Colors.grey,
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: value.listUsers.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 5, top: 5),
                        child: Row(
                          children: [
                            AvatarGlow(
                              showTwoGlows: true,
                              glowColor: Colors.blueAccent,
                              endRadius: 30,
                              child: CircleAvatar(
                                radius: 25,
                                backgroundImage:
                                    NetworkImage(value.listUsers[index].avatar),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(value.listUsers[index].fullname == ''
                                      ? value.listUsers[index].companyname
                                      : value.listUsers[index].fullname)
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            )),
          );
        },
      ),
    );
  }
}
