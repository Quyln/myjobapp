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
              radius: 28,
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
                    fontSize: 20,
                    color: Colors.black),
              ),
              Text(
                'Quản trị viên',
                style: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontSize: 16,
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
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    fontSize: 20),
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
                  'https://th.bing.com/th/id/R.8e15a553c79945c426b3c80bd90f53b6?rik=xEtinSHRUR0Lyg&riu=http%3a%2f%2fupload.wikimedia.org%2fwikipedia%2fcommons%2fd%2fd6%2fGold_coin_icon.png&ehk=TPjFkVPmWqsKBkvQ60u9VfBVF%2fVfwjQcMsd%2fHaA6rrk%3d&risl=&pid=ImgRaw&r=0',
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
