import 'package:flutter/material.dart';
import 'package:myjobapp/JobsPage/jobs_appbar_sec.dart';
import 'package:myjobapp/JobsPage/jobs_body_sec.dart';

class JobsPage extends StatelessWidget {
  const JobsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            JSecAppBar(),
            ShowJSec(),
          ],
        ));
  }
}
