import 'package:flutter/material.dart';
import 'package:myjobapp/NewsPage/news_appbar_sec.dart';
import 'package:myjobapp/NewsPage/news_body_sec.dart';
import 'package:myjobapp/utils/colors.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: maunen,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            AppBarNSec(),
            ShowNSec(),
          ],
        ),
      ),
    );
  }
}
