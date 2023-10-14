import 'package:flutter/material.dart';
import 'package:myjobapp/login_sceen.dart';
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
            padding: const EdgeInsets.only(left: 15),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: Image.network(
                  'https://www.premadegraphics.com/img_1/23/Female-Avatar-2.png'),
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
