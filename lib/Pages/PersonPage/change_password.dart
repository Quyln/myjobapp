import 'package:flutter/material.dart';
import 'package:myjobapp/Pages/Welcome_Login_Pages/Login_Reg_Screen/login_sceen.dart';
import 'package:myjobapp/Provider/login_get_update_user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangPasswordUser extends StatefulWidget {
  const ChangPasswordUser({super.key});

  @override
  State<ChangPasswordUser> createState() => _ChangPasswordUserState();
}

class _ChangPasswordUserState extends State<ChangPasswordUser> {
  final _passcontroller = TextEditingController();
  final _newpasscontroller = TextEditingController();
  final _checknewpasscontroller = TextEditingController();
  bool showpasswordOld = false;
  bool showpasswordNew = false;
  bool showpasswordNewRe = false;
  bool showErrorOld = false;
  bool showErrorNew = false;
  bool showErrorNewRe = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<GetUserProvider>(
      builder: (context, value, child) {
        return Scaffold(
          body: SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 250,
                    width: 250,
                    child: Image.network(
                        'https://www.merideanoverseas.in/frontend/images/web-student-login-img.png'),
                  ),
                  TextFormField(
                    obscureText: showpasswordOld,
                    controller: _passcontroller,
                    onTapOutside: (event) async {
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      String? userpassword = pref.getString('userpassword');
                      if (_passcontroller.text == userpassword) {
                        setState(() {
                          showErrorOld = false;
                        });
                        print(showErrorOld);
                      } else {
                        setState(() {
                          showErrorOld = true;
                        });
                        print(showErrorOld);
                      }
                    },
                    onEditingComplete: () async {
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      String? userpassword = pref.getString('userpassword');
                      if (_passcontroller.text == userpassword) {
                        setState(() {
                          showErrorOld = false;
                        });
                        print(showErrorOld);
                      } else {
                        setState(() {
                          showErrorOld = true;
                        });
                        print(showErrorOld);
                      }
                    },
                    onChanged: (value) {
                      setState(() {
                        showErrorOld = false;
                      });
                    },
                    decoration: InputDecoration(
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              showpasswordOld = !showpasswordOld;
                            });
                          },
                          child: showpasswordOld
                              ? const Icon(Icons.visibility_off)
                              : const Icon(Icons.visibility),
                        ),
                        focusedBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        enabledBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        border: InputBorder.none,
                        labelText: 'Mật khẩu cũ',
                        hintText: 'Nhập mật khẩu cũ...'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  showErrorOld
                      ? const Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Sai mật khẩu hiện tại!',
                            style: TextStyle(fontSize: 12, color: Colors.red),
                          ),
                        )
                      : const SizedBox.shrink(),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _newpasscontroller,
                    obscureText: showpasswordNew,
                    onEditingComplete: () {
                      if (_newpasscontroller.text == _passcontroller.text) {
                        setState(() {
                          showErrorNew = true;
                        });
                      } else {
                        showErrorNew = false;
                      }
                    },
                    onTapOutside: (event) {
                      if (_newpasscontroller.text == _passcontroller.text) {
                        setState(() {
                          showErrorNew = true;
                        });
                      } else {
                        setState(() {
                          showErrorNew = false;
                        });
                      }
                    },
                    onChanged: (value) {
                      setState(() {
                        showErrorNew = false;
                      });
                    },
                    decoration: InputDecoration(
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              showpasswordNew = !showpasswordNew;
                            });
                          },
                          child: showpasswordNew
                              ? const Icon(Icons.visibility_off)
                              : const Icon(Icons.visibility),
                        ),
                        enabledBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        focusedBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        border: InputBorder.none,
                        labelText: 'Mật khẩu mới',
                        hintText: 'Nhập mật khẩu mới...'),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  showErrorNew
                      ? const Text(
                          'Mật khẩu mới không được trùng mật khẩu hiện tại',
                          style: TextStyle(fontSize: 12, color: Colors.red),
                        )
                      : const SizedBox.shrink(),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _checknewpasscontroller,
                    obscureText: showpasswordNewRe,
                    onEditingComplete: () {
                      if (_newpasscontroller.text ==
                          _checknewpasscontroller.text) {
                        setState(() {
                          showErrorNewRe = false;
                        });
                      } else {
                        setState(() {
                          showErrorNewRe = true;
                        });
                      }
                    },
                    onTapOutside: (event) {
                      if (_checknewpasscontroller.text ==
                          _newpasscontroller.text) {
                        setState(() {
                          showErrorNewRe = false;
                        });
                      } else {
                        setState(() {
                          showErrorNewRe = true;
                        });
                      }
                    },
                    onChanged: (value) {
                      setState(() {
                        showErrorNewRe = false;
                      });
                    },
                    decoration: InputDecoration(
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              showpasswordNewRe = !showpasswordNewRe;
                            });
                          },
                          child: showpasswordNewRe
                              ? const Icon(Icons.visibility_off)
                              : const Icon(Icons.visibility),
                        ),
                        enabledBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        focusedBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        border: InputBorder.none,
                        labelText: 'Nhập lại mật khẩu mới',
                        hintText: 'Nhập lại mật khẩu mới...'),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  showErrorNewRe
                      ? const Text(
                          'Vui lòng nhập lại đúng mật khẩu mới',
                          style: TextStyle(fontSize: 12, color: Colors.red),
                        )
                      : const SizedBox.shrink(),
                  GestureDetector(
                    onTap: () async {
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      String? userid = pref.getString('userid');
                      String? userpassword = pref.getString('userpassword');

                      try {
                        if (userpassword != null &&
                            userid != null &&
                            userpassword == _passcontroller.text &&
                            _checknewpasscontroller.text ==
                                _newpasscontroller.text) {
                          value.updatePassword(
                              userid, userpassword, _newpasscontroller.text);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Vui lòng kiểm tra lại thông tin.')));
                        }
                        await pref.setString(
                            'userpassword', _checknewpasscontroller.text);
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                'Đổi mật khẩu thành công! Vui lòng đăng nhập bằng mật khẩu mới')));

                        await pref.setBool('checklogin', false);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString())));
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.blue),
                      padding: const EdgeInsets.all(10),
                      height: 40,
                      width: 100,
                      child: const Center(
                        child: Text(
                          'Xác nhận',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
        );
      },
    );
  }
}
