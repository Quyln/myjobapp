import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
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
  bool loading = false;
  bool _isSnackBarVisible = false;

  void showSnackBar() {
    if (!_isSnackBarVisible) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng kiểm tra lại thông tin.'),
        ),
      );

      setState(() {
        _isSnackBarVisible = true;
      });

      Timer(const Duration(seconds: 5), () {
        setState(() {
          _isSnackBarVisible = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetUserProvider>(
      builder: (context, value, child) {
        return Scaffold(
          body: Stack(
            children: [
              SafeArea(
                  child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                          height: 250,
                          width: 250,
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://www.merideanoverseas.in/frontend/images/web-student-login-img.png',
                            placeholder: (context, url) => Transform.scale(
                              scale: 0.4,
                              child: const CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          )),
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
                          } else {
                            setState(() {
                              showErrorOld = true;
                            });
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
                          } else {
                            setState(() {
                              showErrorOld = true;
                            });
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
                            labelText: 'Mật khẩu hiện tại',
                            hintText: 'Nhập mật khẩu hiện tại...'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      showErrorOld
                          ? const Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'Sai mật khẩu hiện tại!',
                                style:
                                    TextStyle(fontSize: 12, color: Colors.red),
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
                        height: 10,
                      ),
                      showErrorNew
                          ? const Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'Mật khẩu mới không được trùng mật khẩu hiện tại',
                                style:
                                    TextStyle(fontSize: 12, color: Colors.red),
                              ),
                            )
                          : const SizedBox.shrink(),
                      const SizedBox(
                        height: 15,
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
                        height: 10,
                      ),
                      showErrorNewRe
                          ? const Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'Vui lòng nhập lại đúng mật khẩu mới',
                                style:
                                    TextStyle(fontSize: 12, color: Colors.red),
                              ),
                            )
                          : const SizedBox.shrink(),
                      GestureDetector(
                        onTap: () async {
                          setState(() {
                            loading = true;
                          });
                          SharedPreferences pref =
                              await SharedPreferences.getInstance();
                          String? userid = pref.getString('userid');
                          String? userpassword = pref.getString('userpassword');
                          if (_passcontroller.text == userpassword &&
                              _newpasscontroller.text != userpassword &&
                              _checknewpasscontroller.text ==
                                  _newpasscontroller.text) {
                            try {
                              value.updatePassword(userid!, userpassword!,
                                  _newpasscontroller.text);
                              await pref.setString(
                                  'userpassword', _checknewpasscontroller.text);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
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
                            setState(() {
                              loading = false;
                            });
                          } else {
                            setState(() {
                              loading = false;
                            });
                            showSnackBar();
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
                      ),
                    ],
                  ),
                ),
              )),
              Visibility(
                visible: loading,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(color: Colors.black26),
                  child: const Center(
                      child: CircularProgressIndicator(
                    color: Colors.white,
                  )),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
