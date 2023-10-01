import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myjobapp/Classes/home_jobs_class.dart';

class ShowJSec extends StatefulWidget {
  const ShowJSec({super.key});

  @override
  State<ShowJSec> createState() => _ShowJSecState();
}

class _ShowJSecState extends State<ShowJSec> {
  List<JobsClass> alljobdata = [];

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
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
            (context, index) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    height: 180,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            alljobdata[index].image,
                          )),
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: InkWell(
                      onTap: () {},
                      child: Stack(children: [
                        Container(
                          height: double.infinity,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            gradient: const LinearGradient(
                                colors: [Colors.transparent, Colors.black],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    alljobdata[index].position,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ]),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            height: 40,
                            width: 140,
                            decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                    colors: [Colors.transparent, Colors.red],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter),
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(25)),
                            child: Center(
                              child: Text(
                                '230k-490k/day',
                                style: TextStyle(
                                    color: Colors.yellow,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            height: 40,
                            width: 140,
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [Colors.transparent, Colors.white],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter),
                                color: Colors.red,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(25),
                                    topRight: Radius.circular(25))),
                            child: Center(
                              child: Text(
                                alljobdata[index].khuvuctinh,
                                style: const TextStyle(
                                    color: Colors.yellow,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                        )
                      ]),
                    ),
                  ),
                ),
            childCount: alljobdata.length));
  }
}
