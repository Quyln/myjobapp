import 'package:flutter/material.dart';
import 'package:myjobapp/HomePage/home_tincanbiet_section.dart';
import 'package:myjobapp/HomePage/home_tinlaodong_section.dart';
import 'package:myjobapp/HomePage/home_tinnoibat_section.dart';
import 'package:myjobapp/HomePage/home_top_sec.dart';
import 'package:myjobapp/HomePage/home_viecmoinhat_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          const HSecAppBar(),
          SliverList(
              delegate: SliverChildListDelegate([
            const SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, bottom: 10),
                    child: Text(
                      'Tin nổi bật',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w300),
                    ),
                  ),
                  TinNoiBatHSec(),
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                    child: Text(
                      'Cộng đồng lao động',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w300),
                    ),
                  ),
                  TinlaodongHSec(),
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                    child: Text(
                      'Tin cần thiết',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w300),
                    ),
                  ),
                  TincanbietHSec(),
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                    child: Text(
                      'Việc làm mới nhất',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w300),
                    ),
                  ),
                  ViecmoinhatHSec(),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ]))
        ],
      ),
    );
  }
}