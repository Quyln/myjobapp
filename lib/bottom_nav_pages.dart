import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:myjobapp/HomePage/home_page.dart';
import 'package:myjobapp/JobsPage/jobs_page.dart';
import 'package:myjobapp/NewsPage/news_page.dart';

class BottomNavPages extends StatefulWidget {
  const BottomNavPages({super.key});

  @override
  State<BottomNavPages> createState() => _BottomNavPagesState();
}

class _BottomNavPagesState extends State<BottomNavPages> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: CurvedNavigationBar(
        animationCurve: Curves.linearToEaseOut,
        color: Colors.black,
        buttonBackgroundColor: Colors.black,
        index: index,
        backgroundColor: Colors.white,
        items: const [
          Icon(
            Icons.home,
            color: Colors.white,
          ),
          Icon(
            Icons.newspaper,
            color: Colors.white,
          ),
          Icon(
            Icons.work,
            color: Colors.white,
          ),
          Icon(
            Icons.chat,
            color: Colors.white,
          ),
        ],
        animationDuration: const Duration(milliseconds: 300),
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
        child: getSelectedWidget(index: index),
      ),
    );
  }

  Widget getSelectedWidget({required int index}) {
    Widget widget;
    switch (index) {
      case 0:
        widget = const HomePage();
        break;
      case 1:
        widget = const NewsPage();
        break;
      case 2:
        widget = const JobsPage();
        break;
      default:
        widget = const HomePage();
        break;
    }
    return widget;
  }
}
