import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myjobapp/Classes/news_class.dart';
import '../Classes/jobs_class.dart';

class HTinnoibatPro extends ChangeNotifier {
  List<TinTucClass> tinNoiBatHomedata = [];
  // AppDataBase appDataBase = AppDataBase();
  void randomNews() {
    tinNoiBatHomedata.shuffle(Random());
  }

  void getnewlist() async {
    var url = Uri.parse('http://103.176.251.70:100/news/');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> dataList = jsonDecode(response.body);
      tinNoiBatHomedata = dataList.map((e) => TinTucClass.fromJson(e)).toList();
      // for (var element in tinNoiBatHomedata) {
      // appDataBase.insertNews(element);
      // }
      // loadOldlist();
      notifyListeners();
    }
  }

  HTinnoibatPro() {
    getnewlist();
    randomNews();
    // checknetwork();
  }
  // Future loadOldlist() async {
  //   var dataList = await appDataBase.queryNew();
  //   print(dataList);
  //   tinNoiBatHomedata = dataList.map((e) => TinTucClass.fromJson(e)).toList();
  //   notifyListeners();
  // }

  // Future checknetwork() async {
  //   await appDataBase.initDB();

  //   final connectivityResult = await (Connectivity().checkConnectivity());
  //   if (connectivityResult == ConnectivityResult.none) {
  //     loadOldlist();
  //   } else {
  //     getnewlist();
  //   }
  // }
}

class HviecmoinhatPro extends ChangeNotifier {
  List<JobsClass> viecMoiNhatdata = [];

  void getnewlist() async {
    var url = Uri.parse('http://103.176.251.70:100/jobs/alljobs');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> dataList = jsonDecode(response.body);
      viecMoiNhatdata = dataList.map((e) => JobsClass.fromJson(e)).toList();
      notifyListeners();
    }
  }

  HviecmoinhatPro() {
    getnewlist();
  }
}
