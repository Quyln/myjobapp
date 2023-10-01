import 'package:flutter/material.dart';
import 'package:myjobapp/HomePage/home_tincanbiet_section.dart';
import 'package:myjobapp/HomePage/home_tinlaodong_section.dart';
import 'package:myjobapp/HomePage/home_tinnoibat_secnew.dart';
import 'package:myjobapp/HomePage/home_top_section.dart';
import 'package:myjobapp/HomePage/home_viecmoinhat_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromRGBO(220, 223, 229, 1),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopSection(),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                'Tin nổi bật',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            TinNoiBatSNew(),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                'Tin tức công nhân-lao động',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(height: 180, child: TinlaodongHSec()),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                'Việc làm mới nhất',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(height: 180, child: ViecmoinhatHomeSec()),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                'Tin cần thiết',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(height: 180, child: TincanbietHSec()),
          ],
        ),
      )),
    );
  }
}
