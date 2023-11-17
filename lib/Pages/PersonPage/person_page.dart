import 'package:flutter/material.dart';
import 'package:myjobapp/Pages/PersonPage/Tabbar_List/save_tabbar.dart';
import 'package:myjobapp/Provider/login_getuser_provider.dart';
import 'package:provider/provider.dart';

import 'Tabbar_List/done_tabbar.dart';

class PersonPage extends StatefulWidget {
  const PersonPage({super.key});

  @override
  State<PersonPage> createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GetUserProvider>(
      create: (context) {
        return GetUserProvider();
      },
      child: Consumer<GetUserProvider>(
        builder: (context, value, child) {
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
                      title: Text(
                        value.user.fullname,
                        style: const TextStyle(
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
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.white,
                                backgroundImage:
                                    NetworkImage(value.user.avatar),
                              ),
                            ),
                            Text(
                              '@_${value.user.id}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const TabBar(
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
                            const SizedBox(
                                height: 500,
                                child: TabBarView(children: [
                                  DoneTabbar(),
                                  SaveTabbar(),
                                ])),
                            const SizedBox(height: 100),
                          ],
                        ),
                      )
                    ])),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
