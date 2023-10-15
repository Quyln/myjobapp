import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../Classes/home_tintuc_class.dart';

class NewsProvider extends ChangeNotifier {
  List<TinTucClass> allnewdata = [];

  void randomtopics() {
    allnewdata.shuffle(Random());
  }

  void getnewlist() async {
    var response = await http.get(Uri.parse(
        'https://raw.githubusercontent.com/Quyln/myjobapp/main/data/All_news_data.json'));

    if (response.statusCode == 200) {
      List<dynamic> dataList = jsonDecode(response.body);
      allnewdata = dataList.map((e) => TinTucClass.fromJson(e)).toList();
      notifyListeners();
    }
  }

  NewsProvider() {
    getnewlist();
  }
}
