import 'package:flutter/material.dart';
import 'package:myjobapp/Pages/PersonPage/Tabbar_List/posted_job_tabbar.dart';
import 'package:myjobapp/Provider/get_jobs_byid_provider.dart';
import 'package:myjobapp/Provider/login_getuser_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Tabbar_List/applied_tabbar.dart';
import 'Tabbar_List/save_tabbar.dart';

class PersonPage extends StatefulWidget {
  const PersonPage({super.key});

  @override
  State<PersonPage> createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  final _passcontroller = TextEditingController();
  final _newpasscontroller = TextEditingController();
  final _checknewpasscontroller = TextEditingController();
  bool showpassword = false;

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
                                      return Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 20, horizontal: 15),
                                        height: 110,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Column(children: [
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
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return StatefulBuilder(
                                                      builder:
                                                          (context, setState) {
                                                        return AlertDialog(
                                                          title: const Text(
                                                              'Thay đổi mật khẩu'),
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15)),
                                                          actionsPadding:
                                                              const EdgeInsets
                                                                  .all(20),
                                                          actions: [
                                                            TextFormField(
                                                              obscureText:
                                                                  showpassword,
                                                              controller:
                                                                  _passcontroller,
                                                              decoration:
                                                                  InputDecoration(
                                                                      suffixIcon:
                                                                          InkWell(
                                                                        onTap:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            showpassword =
                                                                                !showpassword;
                                                                          });
                                                                        },
                                                                        child: showpassword
                                                                            ? const Icon(Icons.visibility_off)
                                                                            : const Icon(Icons.visibility),
                                                                      ),
                                                                      focusedBorder: const OutlineInputBorder(
                                                                          borderRadius: BorderRadius.all(Radius.circular(
                                                                              15))),
                                                                      enabledBorder: const OutlineInputBorder(
                                                                          borderRadius: BorderRadius.all(Radius.circular(
                                                                              15))),
                                                                      border: InputBorder
                                                                          .none,
                                                                      labelText:
                                                                          'Mật khẩu cũ',
                                                                      hintText:
                                                                          'Nhập mật khẩu cũ...'),
                                                            ),
                                                            const SizedBox(
                                                              height: 20,
                                                            ),
                                                            TextFormField(
                                                              controller:
                                                                  _newpasscontroller,
                                                              decoration:
                                                                  InputDecoration(
                                                                      suffixIcon:
                                                                          InkWell(
                                                                        onTap:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            showpassword =
                                                                                !showpassword;
                                                                          });
                                                                        },
                                                                        child: showpassword
                                                                            ? const Icon(Icons.visibility_off)
                                                                            : const Icon(Icons.visibility),
                                                                      ),
                                                                      enabledBorder: const OutlineInputBorder(
                                                                          borderRadius: BorderRadius.all(Radius.circular(
                                                                              15))),
                                                                      focusedBorder: const OutlineInputBorder(
                                                                          borderRadius: BorderRadius.all(Radius.circular(
                                                                              15))),
                                                                      border: InputBorder
                                                                          .none,
                                                                      labelText:
                                                                          'Mật khẩu mới',
                                                                      hintText:
                                                                          'Nhập mật khẩu mới...'),
                                                            ),
                                                            const SizedBox(
                                                              height: 20,
                                                            ),
                                                            TextFormField(
                                                              controller:
                                                                  _checknewpasscontroller,
                                                              decoration:
                                                                  InputDecoration(
                                                                      suffixIcon:
                                                                          InkWell(
                                                                        onTap:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            showpassword =
                                                                                !showpassword;
                                                                          });
                                                                        },
                                                                        child: showpassword
                                                                            ? const Icon(Icons.visibility_off)
                                                                            : const Icon(Icons.visibility),
                                                                      ),
                                                                      enabledBorder: const OutlineInputBorder(
                                                                          borderRadius: BorderRadius.all(Radius.circular(
                                                                              15))),
                                                                      focusedBorder: const OutlineInputBorder(
                                                                          borderRadius: BorderRadius.all(Radius.circular(
                                                                              15))),
                                                                      border: InputBorder
                                                                          .none,
                                                                      labelText:
                                                                          'Nhập lại mật khẩu mới',
                                                                      hintText:
                                                                          'Nhập lại mật khẩu mới...'),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () async {
                                                                SharedPreferences
                                                                    pref =
                                                                    await SharedPreferences
                                                                        .getInstance();
                                                                String?
                                                                    userpassword =
                                                                    pref.getString(
                                                                        'userpassword');
                                                                if (userpassword !=
                                                                        null &&
                                                                    userpassword ==
                                                                        _passcontroller
                                                                            .text &&
                                                                    _checknewpasscontroller
                                                                            .text ==
                                                                        _newpasscontroller
                                                                            .text) {}
                                                              },
                                                              child: Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                        .all(10),
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15),
                                                                    color: Colors
                                                                        .blue),
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(10),
                                                                height: 40,
                                                                width: 90,
                                                                child:
                                                                    const Center(
                                                                  child: Text(
                                                                    'Xác nhận',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  });
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
