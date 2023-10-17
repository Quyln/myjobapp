import 'package:flutter/material.dart';
import 'package:myjobapp/Pages/ChatPage/chat_page.dart';
import 'package:myjobapp/Pages/HomePage/home_page.dart';
import 'package:myjobapp/Pages/JobsPage/jobs_page.dart';
import 'package:myjobapp/Pages/NewsPage/news_page.dart';
import 'package:myjobapp/Pages/PersonPage/person_page.dart';

class BottomBarNav extends StatefulWidget {
  const BottomBarNav({super.key, required this.pageindex});
  final int pageindex;
  @override
  State<BottomBarNav> createState() => _BottomBarNavState();
}

class _BottomBarNavState extends State<BottomBarNav> {
  int _pageindex = 2;
  final List<Widget> _pages = [
    const NewsPage(),
    const JobsPage(),
    const HomePage(),
    const ChatPage(),
    const PersonPage()
  ];
  @override
  void initState() {
    super.initState();
    _pageindex = widget.pageindex;
  }

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
              child: _pages.elementAt(_pageindex)),
          Align(
            alignment: const Alignment(0, 1.0),
            child: AnimatedOpacity(
              opacity: _visible ? 1 : 0,
              duration: const Duration(milliseconds: 500),
              child: BottomNavigationBar(
                selectedLabelStyle: const TextStyle(fontSize: 14),
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
                    icon: Icon(Icons.newspaper),
                    label: 'Tin Tức',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.work),
                    label: 'Việc Làm',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                    ),
                    label: 'Trang Chủ',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.chat),
                    label: 'Chat',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Tài Khoản',
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
