import 'package:flutter/material.dart';
import 'package:myjobapp/Pages/HomePage/home_tinnoibat_section.dart';
import 'package:myjobapp/Pages/HomePage/home_top_sec.dart';
import 'package:myjobapp/Pages/HomePage/home_viecmoinhat_section.dart';
import 'package:myjobapp/utils/colors_texts_style.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
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
                      style: tHeadline,
                    ),
                  ),
                  TinNoiBatHSec(),
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                    child: Text(
                      'Việc làm mới nhất',
                      style: tHeadline,
                    ),
                  ),
                  ViecmoinhatHSec(),
                  SizedBox(
                    height: 100,
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
