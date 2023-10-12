import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myjobapp/JobsPage/jobs_appbar_sec.dart';
import 'package:myjobapp/JobsPage/jobs_body_sec.dart';
import 'package:http/http.dart' as http;

import '../Classes/home_jobs_class.dart';

class JobsPage extends StatefulWidget {
  const JobsPage({super.key});

  @override
  State<JobsPage> createState() => _JobsPageState();
}

class _JobsPageState extends State<JobsPage> {
  List<JobsClass> alljobdata = [];
  List<JobsClass> filterJobData = [];

  @override
  void initState() {
    super.initState();
    getnewlist();
  }

  void getnewlist() async {
    var url = Uri.parse(
        'https://raw.githubusercontent.com/Quyln/myjobapp/main/data/All_jobs_data.json');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> dataList = jsonDecode(response.body);
      alljobdata = dataList.map((e) => JobsClass.fromJson(e)).toList();
      setState(() {
        alljobdata;
        filterJobData = alljobdata;
      });
    }
  }

  void onpresssearch(String selectedText) {
    filterJobData = alljobdata.where((element) {
      return element.khuvuctinh == selectedText;
    }).toList();
    setState(() {
      filterJobData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            JSecAppBar(
              onpresssearch: onpresssearch,
            ),
            ShowJSec(
              alljobdata: filterJobData,
            ),
          ],
        ));
  }
}
