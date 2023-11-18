import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myjobapp/Classes/component/fotgot_pass_user.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({super.key});

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  final _emailcontroller = TextEditingController();
  final _idcontroller = TextEditingController();

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
                    hintText: 'ID đăng nhập...',
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
                controller: _emailcontroller,
                textAlignVertical: TextAlignVertical.center,
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.mail,
                    color: Colors.black,
                  ),
                  hintText: 'Email...',
                  border: InputBorder.none,
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 10, right: 30, bottom: 10),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Quay lại đăng nhập...')),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () async {
                    if (_idcontroller.text.isNotEmpty &&
                        _emailcontroller.text.isNotEmpty) {
                      ForgotPassUser getPassBody = ForgotPassUser(
                          id: _idcontroller.text, email: _emailcontroller.text);
                      Map<String, dynamic> getPassBodyJSON =
                          ForgotPassUser.toJson(getPassBody);
                      var url = Uri.parse(
                          'http://103.176.251.70:100/users/forgot-password');

                      var response =
                          await http.post(url, body: getPassBodyJSON);
                      if (response.statusCode == 201) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            behavior: SnackBarBehavior.floating,
                            content: Text(
                                'Mật khẩu mới đã được gửi về Email của bạn')));
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                behavior: SnackBarBehavior.floating,
                                content: Text('Sai ID hoặc Email')));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          behavior: SnackBarBehavior.floating,
                          content: Text(
                              'Vui lòng điền đầy đủ thông tin bạn nhé !')));
                    }
                  },
                  child: Container(
                    height: 50,
                    width: 130,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.red),
                    child: const Center(
                      child: Text(
                        'XÁC NHẬN',
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
