import 'package:flutter/material.dart';
import 'package:myjobapp/HomePage/home_tinnoibat_section.dart';
import 'package:myjobapp/HomePage/home_top_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromRGBO(220, 223, 229, 1),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopSection(),
          SizedBox(
            height: 20,
          ),
          Text(
            'Tin nổi bật',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 180, child: TinNoiBatSec())
        ],
      )),
    );
  }
}
