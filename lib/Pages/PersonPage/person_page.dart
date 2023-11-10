import 'package:flutter/material.dart';
import 'package:myjobapp/Pages/PersonPage/Tabbar_List/save_tabbar.dart';
import 'package:myjobapp/utils/colors_texts_style.dart';

import 'Tabbar_List/done_tabbar.dart';

class PersonPage extends StatefulWidget {
  const PersonPage({super.key});

  @override
  State<PersonPage> createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.transparent,
                leading: IconButton(
                  onPressed: () {},
                  icon: Image.network(
                    'https://th.bing.com/th/id/R.cef7ade7807f8c0d60886922e91316c2?rik=vM3X8FUbkNUInw&pid=ImgRaw&r=0',
                    width: 30,
                    height: 30,
                  ),
                ),
                title: const Text(
                  'Trần Khả Như',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.normal),
                ),
                actions: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.menu,
                        color: Colors.black,
                      ))
                ],
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                const SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: avatar,
                        ),
                      ),
                      Text(
                        '@_yourid999',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TabBar(
                          indicatorColor: Colors.green,
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.grey,
                          tabs: [
                            Tab(
                                text: 'Đã ứng tuyển',
                                icon: Icon(
                                  Icons.library_add_check,
                                  color: Colors.green,
                                )),
                            Tab(
                                text: 'Đã lưu ',
                                icon: Icon(
                                  Icons.favorite_sharp,
                                  color: Colors.pink,
                                )),
                          ]),
                      SizedBox(
                          height: 500,
                          child: TabBarView(children: [
                            DoneTabbar(),
                            SaveTabbar(),
                          ])),
                      SizedBox(height: 100),
                    ],
                  ),
                )
              ])),
            ],
          ),
        ),
      ),
    );
  }
}
