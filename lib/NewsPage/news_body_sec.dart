import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myjobapp/Classes/home_tintuc_class.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ShowNSec extends StatefulWidget {
  const ShowNSec({super.key});

  @override
  State<ShowNSec> createState() => _ShowNSecState();
}

class _ShowNSecState extends State<ShowNSec> {
  List<TinTucClass> allnewdata = [];

  @override
  void initState() {
    super.initState();
    getnewlist();
  }

  void randomtopics() {
    setState(() {
      allnewdata.shuffle(Random());
    });
  }

  void getnewlist() async {
    var response = await http.get(Uri.parse(
        'https://raw.githubusercontent.com/Quyln/myjobapp/main/data/All_news_data.json'));

    if (response.statusCode == 200) {
      List<dynamic> dataList = jsonDecode(response.body);
      allnewdata = dataList.map((e) => TinTucClass.fromJson(e)).toList();
      setState(() {
        allnewdata;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    randomtopics();
    return SliverList(
        delegate: SliverChildBuilderDelegate(
            (context, index) => Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Container(
                    height: 230,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                            allnewdata[index].image,
                          )),
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: InkWell(
                      onTap: () {
                        launchUrlString(allnewdata[index].link);
                      },
                      child: Container(
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
                                  allnewdata[index].title,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Image.network(
                                  allnewdata[index].author,
                                  height: 20,
                                  width: 60,
                                  fit: BoxFit.contain,
                                )
                              ]),
                        ),
                      ),
                    ),
                  ),
                ),
            childCount: allnewdata.length));
  }
}
