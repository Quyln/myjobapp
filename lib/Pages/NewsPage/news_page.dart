import 'package:flutter/material.dart';
import 'package:myjobapp/Pages/NewsPage/news_appbar_sec.dart';
import 'package:myjobapp/Pages/NewsPage/news_body_sec.dart';
import 'package:myjobapp/Provider/news_list_provider.dart';
import 'package:provider/provider.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NewsProvider>(
      create: (context) {
        return NewsProvider();
      },
      child: Consumer<NewsProvider>(
        builder: (context, value, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: CustomScrollView(
              slivers: [
                const AppBarNSec(),
                ShowNSec(
                  data: value.allnewdata,
                  randomtoppics: value.randomtopics,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
