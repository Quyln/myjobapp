import 'package:flutter/material.dart';
import 'package:myjobapp/bottom_nav_pages.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _idcontroller = TextEditingController();
  final _passcontroller = TextEditingController();

  bool showpassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 100, left: 10, right: 10, bottom: 30),
            child: Image.asset(
              height: 250,
              fit: BoxFit.contain,
              'images/login.png',
            ),
          ),
          Container(
            height: 50,
            width: 300,
            decoration: const BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: TextField(
              controller: _idcontroller,
              textAlignVertical: TextAlignVertical.center,
              decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  hintText: 'Your ID...',
                  border: InputBorder.none),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 50,
            width: 300,
            decoration: const BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: TextField(
              controller: _passcontroller,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                hintText: 'Your Password...',
                border: InputBorder.none,
                suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      showpassword = !showpassword;
                    });
                  },
                  child: showpassword
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility),
                ),
              ),
              obscureText: showpassword,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, right: 30, bottom: 20),
            child: InkWell(
              onTap: () {},
              child: const Align(
                alignment: Alignment.centerRight,
                child: Text('Quên mật khẩu?'),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {},
                child: Container(
                  height: 50,
                  width: 110,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.green),
                  child: const Center(
                    child: Text(
                      'ĐĂNG KÝ',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BottomNavPages()));
                },
                child: Container(
                  height: 50,
                  width: 130,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue),
                  child: const Center(
                    child: Text(
                      'ĐĂNG NHẬP',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      )),
    );
  }
}
