import 'package:flutter/material.dart';
import 'package:myjobapp/Pages/PersonPage/Tabbar_List/posted_job_tabbar.dart';
import 'package:myjobapp/Provider/get_jobs_byid_provider.dart';
import 'package:myjobapp/Provider/login_get_update_user_provider.dart';
import 'package:provider/provider.dart';
import 'Tabbar_List/applied_tabbar.dart';
import 'Tabbar_List/save_tabbar.dart';
import 'change_password.dart';

class PersonPage extends StatefulWidget {
  const PersonPage({super.key});

  @override
  State<PersonPage> createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GetPostedJobsByID>(
      builder: (context, value, child) {
        return Consumer<GetUserProvider>(
          builder: (context, uservalue, child) {
            uservalue.getPreGetUser();
            return DefaultTabController(
              length: uservalue.user.position == 'Thành viên' ? 2 : 1,
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
                        title: Center(
                          child: uservalue.user.position == 'Thành viên'
                              ? Text(
                                  uservalue.user.fullname,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal),
                                )
                              : Text(
                                  uservalue.user.companyname,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal),
                                ),
                        ),
                        actions: [
                          IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15))),
                                    context: context,
                                    builder: (context) {
                                      return StatefulBuilder(
                                        builder: (context, setState) {
                                          return Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 20, horizontal: 15),
                                            height: 110,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Column(children: [
                                              GestureDetector(
                                                child: const Row(
                                                  children: [
                                                    Icon(Icons
                                                        .qr_code_2_outlined),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      'Mã QR của tôi',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              const Divider(
                                                indent: 5,
                                                thickness: 1,
                                                height: 3,
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              GestureDetector(
                                                child: const Row(
                                                  children: [
                                                    Icon(Icons.change_circle),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      'Đổi mật khẩu',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const ChangPasswordUser()));
                                                },
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              const Divider(
                                                indent: 5,
                                                thickness: 1,
                                                height: 3,
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              GestureDetector(
                                                child: const Row(
                                                  children: [
                                                    Icon(Icons
                                                        .settings_outlined),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      'Cài đặt và quyền riêng tư',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                onTap: () {
                                                  Navigator.of(context)
                                                      .pop('Option 3');
                                                },
                                              ),
                                            ]),
                                          );
                                        },
                                      );
                                    });
                              },
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
                                  radius: 40,
                                  backgroundColor: Colors.white,
                                  backgroundImage:
                                      NetworkImage(uservalue.user.avatar),
                                ),
                              ),
                              Text(
                                '@_${uservalue.user.id}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  height: 40,
                                  width: 110,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: const Center(child: Text('Sửa hồ sơ')),
                                ),
                              ),
                              uservalue.user.position == 'Thành viên'
                                  ? const TabBar(
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
                                        ])
                                  : TabBar(
                                      indicatorSize: TabBarIndicatorSize.label,
                                      indicatorColor: Colors.blue[780],
                                      labelColor: Colors.black,
                                      tabs: const [
                                          Tab(
                                            text: 'Bài tuyển dụng của tôi',
                                          ),
                                        ]),
                              SizedBox(
                                  height: 500,
                                  child: uservalue.user.position == 'Thành viên'
                                      ? TabBarView(children: [
                                          AppliedTabbar(
                                            userData: uservalue.user,
                                          ),
                                          SaveTabbar(
                                            userData: uservalue.user,
                                          ),
                                        ])
                                      : TabBarView(children: [
                                          PostedJobTabbar(
                                            userData: uservalue.user,
                                          ),
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
        );
      },
    );
  }
}
