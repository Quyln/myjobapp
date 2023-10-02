import 'package:flutter/material.dart';
import 'package:myjobapp/Classes/home_jobs_class.dart';

class JobsDetailScr extends StatefulWidget {
  const JobsDetailScr({required this.data, super.key});

  final JobsClass data;

  @override
  State<JobsDetailScr> createState() => _JobsDetailScrState();
}

class _JobsDetailScrState extends State<JobsDetailScr> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(220, 223, 229, 1),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.black,
        ),
        title: Text(
          widget.data.title,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [Text(widget.data.title)],
      )),
    );
  }
}
