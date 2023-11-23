import 'package:flutter/material.dart';
import 'package:myjobapp/Provider/get_jobs_byid.dart';
import 'package:provider/provider.dart';

import '../../Classes/user_class.dart';
import 'Tabbar_List/applied_tabbar.dart';
import 'Tabbar_List/save_tabbar.dart';

class PersonPMember extends StatelessWidget {
  const PersonPMember({super.key, required this.userData});
  final User userData;

  @override
  Widget build(BuildContext context) {
    return Consumer<GetJobsByID>(
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
                    title: userData.position == 'Thành viên'
                        ? Center(
                            child: Text(
                              userData.fullname,
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal),
                            ),
                          )
                        : Center(
                            child: Text(
                              userData.companyname,
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                    actions: [
                      IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: [
                                        GestureDetector(
                                          child: const Row(
                                            children: [
                                              Icon(Icons.qr_code_2_outlined),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                'Mã QR của tôi',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          onTap: () {
                                            // Handle option 1
                                            Navigator.of(context)
                                                .pop('Option 1');
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
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          onTap: () {
                                            // Handle option 2
                                            Navigator.of(context)
                                                .pop('Option 2');
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
                                              Icon(Icons.settings_outlined),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                'Cài đặt và quyền riêng tư',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          onTap: () {
                                            // Handle option 2
                                            Navigator.of(context)
                                                .pop('Option 3');
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ).then((value) {
                              // Handle the selected option here
                              if (value != null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('Selected option: $value')),
                                );
                              }
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
                              backgroundImage: NetworkImage(userData.avatar),
                            ),
                          ),
                          Text(
                            '@_${userData.id}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
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
                          // value.user.position == 'Thành viên'
                          //     ?
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
                                AppliedTabbar(),
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
    );
  }
}
