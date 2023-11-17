import 'package:flutter/material.dart';
import 'package:myjobapp/Pages/Welcome_Login_Pages/Login_Reg_Screen/Reg_tabbar/reg_creator_tabbar.dart';
import 'package:myjobapp/Pages/Welcome_Login_Pages/Login_Reg_Screen/Reg_tabbar/reg_member_tabbar.dart';

class RegScreen extends StatefulWidget {
  const RegScreen({super.key});

  @override
  State<RegScreen> createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
  bool showpassword = true;
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 20, left: 10, right: 10, bottom: 20),
                child: Image.asset(
                  height: 200,
                  fit: BoxFit.contain,
                  'images/login.png',
                ),
              ),
              const TabBar(
                labelColor: Colors.black,
                indicatorColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                indicatorSize: TabBarIndicatorSize.label,
                tabs: [
                  Tab(
                    icon: Icon(
                      Icons.person,
                      color: Colors.blue,
                    ),
                    text: 'THÀNH VIÊN',
                  ),
                  Tab(
                    icon: Icon(
                      Icons.group,
                      color: Colors.blue,
                    ),
                    text: 'NHÀ TUYỂN DỤNG',
                  ),
                ],
              ),
              const SizedBox(
                height: 430,
                child: TabBarView(children: [RegMember(), RegCreator()]),
              )
            ],
          ),
        )),
      ),
    );
  }
}
