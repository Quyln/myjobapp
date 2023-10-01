import 'package:flutter/material.dart';
import 'package:myjobapp/JobsPage/jobs_appbar_sec.dart';
import 'package:myjobapp/JobsPage/news_body_sec%20copy.dart';

class JobsPage extends StatelessWidget {
  const JobsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Color.fromRGBO(220, 223, 229, 1),
        body: SafeArea(
            child: CustomScrollView(
          slivers: [
            JSecAppBar(),
            ShowJSec(),
          ],
        )));
  }
}
