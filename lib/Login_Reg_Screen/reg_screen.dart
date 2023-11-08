import 'package:flutter/material.dart';
import 'package:myjobapp/Login_Reg_Screen/login_sceen.dart';
import 'package:myjobapp/utils/list_tinh_huyen_cv.dart';

class RegScreen extends StatefulWidget {
  const RegScreen({super.key});

  @override
  State<RegScreen> createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
  final _idcontroller = TextEditingController();
  final _passcontroller = TextEditingController();
  final _phonecontroller = TextEditingController();
  final _fullnamecontroller = TextEditingController();

  bool showpassword = true;
  String? selectedValue;
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
                height: 200,
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
                controller: _fullnamecontroller,
                textAlignVertical: TextAlignVertical.center,
                decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                    hintText: 'Họ và tên',
                    border: InputBorder.none),
              ),
            ),
            const SizedBox(
              height: 10,
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
                    hintText: 'ID đăng nhập...',
                    border: InputBorder.none),
              ),
            ),
            const SizedBox(
              height: 10,
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
                  hintText: 'Mật khẩu...',
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
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              width: 300,
              decoration: const BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: TextField(
                controller: _phonecontroller,
                textAlignVertical: TextAlignVertical.center,
                decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.phone,
                      color: Colors.black,
                    ),
                    hintText: 'Số điện thoại...',
                    border: InputBorder.none),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              height: 50,
              width: 300,
              decoration: const BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Row(
                children: [
                  const Icon(Icons.work),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          menuMaxHeight: 400,
                          borderRadius: BorderRadius.circular(25),
                          value: selectedValue,
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value;
                            });
                          },
                          isExpanded: true,
                          hint: const Text('Việc làm gần nhất...'),
                          items: listcongviec
                              .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(
                                    e,
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.black),
                                  )))
                              .toList()),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, right: 30, bottom: 15),
              child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Quay lại đăng nhập...'),
                    ],
                  )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        behavior: SnackBarBehavior.floating,
                        content: Text('Bạn đã đăng ký thành công')));
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                  },
                  child: Container(
                    height: 50,
                    width: 150,
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
              ],
            )
          ],
        ),
      )),
    );
  }
}
