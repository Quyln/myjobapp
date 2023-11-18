import 'package:flutter/material.dart';
import 'package:myjobapp/Classes/component/create_user_class.dart';
import 'package:myjobapp/Pages/Welcome_Login_Pages/Login_Reg_Screen/login_sceen.dart';
import 'package:myjobapp/Provider/reg_users_provider.dart';
import 'package:provider/provider.dart';

class RegCreator extends StatefulWidget {
  const RegCreator({super.key});

  @override
  State<RegCreator> createState() => _RegCreatorState();
}

class _RegCreatorState extends State<RegCreator> {
  final _idcontroller = TextEditingController();
  final _passcontroller = TextEditingController();
  final _phonecontroller = TextEditingController();
  final _companynamecontroller = TextEditingController();
  final _companytaxcontroller = TextEditingController();
  final _emailcontroller = TextEditingController();

  bool showpassword = true;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegUserProvider>(
      create: (context) {
        return RegUserProvider();
      },
      child: Consumer<RegUserProvider>(
        builder: (context, value, child) {
          return Scaffold(
            body: SafeArea(
                child: SingleChildScrollView(
              child: Column(
                children: [
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
                      controller: _companynamecontroller,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.business_rounded,
                            color: Colors.black,
                          ),
                          hintText: 'Tên công ty...',
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
                      controller: _companytaxcontroller,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.source,
                            color: Colors.black,
                          ),
                          hintText: 'Mã số thuế...',
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
                      controller: _emailcontroller,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.black,
                          ),
                          hintText: 'Email...',
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
                  Padding(
                      padding:
                          const EdgeInsets.only(top: 10, right: 30, bottom: 10),
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
                        onTap: () {
                          if (_companynamecontroller.text.isNotEmpty &&
                              _idcontroller.text.isNotEmpty &&
                              _passcontroller.text.isNotEmpty &&
                              _phonecontroller.text.isNotEmpty &&
                              _companytaxcontroller.text.isNotEmpty) {
                            String companyname = _companynamecontroller.text;
                            String companytax = _companytaxcontroller.text;
                            String id = _idcontroller.text;
                            String password = _passcontroller.text;
                            String phone = _phonecontroller.text;
                            String email = _emailcontroller.text;

                            CreateUserDto newUser = CreateUserDto(
                                id: id,
                                avatar:
                                    'https://cdn-icons-png.flaticon.com/512/6386/6386976.png',
                                fullname: '',
                                lastjob: '',
                                password: password,
                                phone: phone,
                                email: email,
                                position: 'Nhà tuyển dụng',
                                token: '1',
                                companyname: companyname,
                                companytax: companytax);
                            Map<String, dynamic> newUserJson = newUser.toJson();

                            value.createUser(newUserJson);

                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    content:
                                        Text('Bạn đã đăng ký thành công')));
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    content: Text(
                                        'Vui lòng điền đầy đủ thông tin khi đăng bài')));
                          }
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
        },
      ),
    );
  }
}
