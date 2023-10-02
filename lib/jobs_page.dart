import 'package:flutter/material.dart';
import 'package:myjobapp/JobsPage/jobs_appbar_sec.dart';
import 'package:myjobapp/JobsPage/jobs_body_sec.dart';
import 'package:myjobapp/utils/colors.dart';

class JobsPage extends StatelessWidget {
  const JobsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: maunen,
        body: SafeArea(
            child: CustomScrollView(
          slivers: [
            JSecAppBar(),
            ShowJSec(),
          ],
        )));
  }
}
