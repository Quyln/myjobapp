import 'package:flutter/material.dart';
import 'package:myjobapp/HomePage/home_page.dart';
import 'package:myjobapp/JobsPage/jobs_page.dart';
import 'package:myjobapp/NewsPage/news_page.dart';

class BottomBarNav extends StatefulWidget {
  const BottomBarNav({super.key});

  @override
  State<BottomBarNav> createState() => _BottomBarNavState();
}

class _BottomBarNavState extends State<BottomBarNav> {
  int _pageindex = 0;
  List<Widget> _Pages = [
    const HomePage(),
    const NewsPage(),
    const JobsPage(),
  ];

  bool _visible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification is ScrollUpdateNotification) {
                  setState(() {
                    _visible = notification.scrollDelta! < 0;
                  });
                }
                return false;
              },
              child: _Pages.elementAt(_pageindex)),
          Align(
            alignment: const Alignment(0, 1.05),
            child: AnimatedOpacity(
              opacity: _visible ? 1 : 0,
              duration: const Duration(milliseconds: 500),
              child: BottomNavigationBar(
                selectedItemColor: Colors.black,
                unselectedItemColor: Colors.black54,
                backgroundColor: Colors.white,
                showSelectedLabels: true,
                showUnselectedLabels: false,
                currentIndex: _pageindex,
                onTap: (value) {
                  setState(() {
                    _pageindex = value;
                  });
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                    ),
                    label: 'Trang Chủ',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.newspaper),
                    label: 'Tin Tức',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.work),
                    label: 'Việc Làm',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
