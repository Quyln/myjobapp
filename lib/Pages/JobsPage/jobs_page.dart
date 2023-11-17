import 'package:flutter/material.dart';
import 'package:myjobapp/Pages/JobsPage/jobs_appbar_sec.dart';
import 'package:myjobapp/Pages/JobsPage/jobs_body_sec.dart';
import 'package:myjobapp/Provider/Job_list_provider.dart';
import 'package:provider/provider.dart';

class JobsPage extends StatefulWidget {
  const JobsPage({super.key});

  @override
  State<JobsPage> createState() => _JobsPageState();
}

class _JobsPageState extends State<JobsPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<JobsProvider>(
      create: (context) {
        return JobsProvider();
      },
      child: Consumer<JobsProvider>(
        builder: (context, value, child) {
          return Scaffold(
              backgroundColor: Colors.white,
              body: CustomScrollView(
                slivers: [
                  JSecAppBar(
                    data: value.alljobdata,
                    onpresssearch: value.onpresssearch,
                  ),
                  ShowJSec(
                    filterJobData: value.filterJobData,
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 60),
                  )
                ],
              ));
        },
      ),
    );
  }
}
