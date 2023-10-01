import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:myjobapp/Classes/home_tintuc_class.dart';

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

  void getnewlist() async {
    var url = Uri.parse(
        'https://raw.githubusercontent.com/Quyln/myjobapp/main/data/home_tinnoibat.json');
    var response = await http.get(url);

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
    return SliverList(
        delegate: SliverChildBuilderDelegate(
            (context, index) => ListTile(
                  title: Text(
                    allnewdata[index].title,
                    style: const TextStyle(fontSize: 18),
                  ),
                  leading: Image.network(
                    allnewdata[index].image,
                    width: 50,
                    height: 200,
                    fit: BoxFit.fitHeight,
                  ),
                ),
            childCount: allnewdata.length));
  }
}
