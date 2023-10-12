import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myjobapp/Classes/home_jobs_class.dart';
import 'package:myjobapp/JobsPage/jobs_detail_screen.dart';

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
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
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
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => JobsDetailScr(
                                data: alljobdata[index],
                              ),
                            ));
                      },
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
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '${alljobdata[index].salary} triệu',
                                    style: const TextStyle(
                                        color: Colors.yellow,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ]),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Column(
                            children: [
                              Container(
                                height: 30,
                                width: 135,
                                decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: [
                                          Colors.transparent,
                                          Colors.white
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter),
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(25),
                                        topRight: Radius.circular(25))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      size: 20,
                                      color: Colors.yellow,
                                    ),
                                    Text(
                                      alljobdata[index].khuvuctinh,
                                      style: const TextStyle(
                                          color: Colors.yellow,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
            childCount: alljobdata.length));
  }
}
