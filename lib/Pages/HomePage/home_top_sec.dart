import 'package:flutter/material.dart';
import 'package:myjobapp/Login_Reg_Screen/login_sceen.dart';
import 'package:myjobapp/bottombar_nav.dart';
import 'package:myjobapp/utils/colors_texts_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HSecAppBar extends StatelessWidget {
  const HSecAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      pinned: false,
      backgroundColor: Colors.white,
      leadingWidth: 220,
      leading: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BottomBarNav(
                              pageindex: 4,
                            )));
              },
              child: const CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white,
                backgroundImage: avatar,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Trần Khả Như',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black),
              ),
              Text(
                'Quản trị viên',
                style: TextStyle(
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
              const Text(
                '1,500',
                style: TextStyle(
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
  }
}
