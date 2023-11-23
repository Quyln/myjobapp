import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myjobapp/Pages/Welcome_Login_Pages/Login_Reg_Screen/login_sceen.dart';
import 'package:myjobapp/Provider/login_getuser_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Classes/user_class.dart';

class HSecAppBar extends StatefulWidget {
  const HSecAppBar({super.key});

  @override
  State<HSecAppBar> createState() => _HSecAppBarState();
}

class _HSecAppBarState extends State<HSecAppBar> {
  User user = User(
    id: '',
    avatar: '',
    fullname: '',
    lastjob: '',
    password: '',
    phone: '',
    position: '',
    savejobs: '',
    appliedjobs: '',
    postedjobs: '',
    token: 1,
    companyname: '',
    companytax: '',
  );
  @override
  Widget build(BuildContext context) {
    return Consumer<GetUserProvider>(
      builder: (context, value, child) {
        final token = NumberFormat('#,###').format(value.user.token);
        return SliverAppBar(
          floating: true,
          pinned: false,
          backgroundColor: Colors.white,
          leadingWidth: 290,
          leading: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: InkWell(
                  onTap: () {},
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(value.user.avatar),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 210,
                    child: Text(
                      value.user.position == 'Thành viên'
                          ? value.user.fullname
                          : value.user.companyname,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    value.user.position,
                    style: const TextStyle(
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                        color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Row(
                children: [
                  Text(
                    token,
                    style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.red,
                        fontSize: 16),
                  ),
                  InkWell(
                    onTap: () async {
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      await pref.setBool('checklogin', false);

                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    },
                    child: Image.network(
                      'https://th.bing.com/th/id/R.cef7ade7807f8c0d60886922e91316c2?rik=vM3X8FUbkNUInw&pid=ImgRaw&r=0',
                      width: 30,
                      height: 30,
                    ),
                  )
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
