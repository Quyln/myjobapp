import 'dart:async';
import 'package:after_layout/after_layout.dart';

import 'package:flutter/material.dart';
import 'package:myjobapp/Login_Reg_Page/forgotpass_screen.dart';
import 'package:myjobapp/Login_Reg_Page/reg_screen.dart';
import 'package:myjobapp/bottombar_nav.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with AfterLayoutMixin<LoginScreen> {
  final _idcontroller = TextEditingController();
  final _passcontroller = TextEditingController();

  bool showpassword = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    checkloginSH(context);
  }

  void checkloginSH(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool? checklogin = pref.getBool('checklogin');
    if (checklogin == true) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: ((context) => const BottomBarNav())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
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
                    Icons.key,
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
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ForgotPass()));
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Quên mật khẩu?'),
                    ],
                  )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegScreen()));
                  },
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
                  onTap: () async {
                    bool result = true;
                    if (result == true) {
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      await pref.setBool('checklogin', true);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => BottomBarNav())));
                    }
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
        ),
      )),
    );
  }
}