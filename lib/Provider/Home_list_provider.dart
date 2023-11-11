import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myjobapp/Classes/tintuc_class.dart';
import 'package:myjobapp/utils/app_database.dart';
import '../Classes/jobs_class.dart';

class HTinnoiboPro extends ChangeNotifier {
  List<TinTucClass> tinNoiBatHomedata = [];
  AppDataBase appDataBase = AppDataBase();
  void getnewlist() async {
    var url = Uri.parse(
        'https://raw.githubusercontent.com/Quyln/myjobapp/main/data/home_tinnoibat.json');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> dataList = jsonDecode(response.body);
      tinNoiBatHomedata = dataList.map((e) => TinTucClass.fromJson(e)).toList();
      for (var element in tinNoiBatHomedata) {
        appDataBase.insertNews(element);
      }
      loadOldlist();
      notifyListeners();
    }
  }

  HTinnoiboPro() {
    checknetwork();
  }
  Future loadOldlist() async {
    var dataList = await appDataBase.queryNew();
    print(dataList);
    tinNoiBatHomedata = dataList.map((e) => TinTucClass.fromJson(e)).toList();
    notifyListeners();
  }

  Future checknetwork() async {
    await appDataBase.initDB();

    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      loadOldlist();
    } else {
      getnewlist();
    }
  }
}

class HTinlaodongPro extends ChangeNotifier {
  List<TinTucClass> tinLaoDongdata = [];

  void getnewlist() async {
    var url = Uri.parse(
        'https://raw.githubusercontent.com/Quyln/myjobapp/main/data/home_tinlaodong.json');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> dataList = jsonDecode(response.body);
      tinLaoDongdata = dataList.map((e) => TinTucClass.fromJson(e)).toList();
      notifyListeners();
    }
  }

  HTinlaodongPro() {
    getnewlist();
  }
}

class HtincanbietPro extends ChangeNotifier {
  List<TinTucClass> tinCanBietdata = [];

  void getnewlist() async {
    var url = Uri.parse(
        'https://raw.githubusercontent.com/Quyln/myjobapp/main/data/home_tincanbiet.json');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> dataList = jsonDecode(response.body);
      tinCanBietdata = dataList.map((e) => TinTucClass.fromJson(e)).toList();
      notifyListeners();
    }
  }

  HtincanbietPro() {
    getnewlist();
  }
}

class HviecmoinhatPro extends ChangeNotifier {
  List<JobsClass> viecMoiNhatdata = [];

  void getnewlist() async {
    var url = Uri.parse('http://localhost:3000/jobs/');
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
