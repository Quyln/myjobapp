import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Classes/home_jobs_class.dart';
import '../Classes/home_tintuc_class.dart';

class HTinnoiboPro extends ChangeNotifier {
  List<TinTucClass> tinNoiBatHomedata = [];

  void getnewlist() async {
    var url = Uri.parse(
        'https://raw.githubusercontent.com/Quyln/myjobapp/main/data/home_tinnoibat.json');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> dataList = jsonDecode(response.body);
      tinNoiBatHomedata = dataList.map((e) => TinTucClass.fromJson(e)).toList();
      notifyListeners();
    }
  }

  HTinnoiboPro() {
    getnewlist();
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
    var url = Uri.parse(
        'https://raw.githubusercontent.com/Quyln/myjobapp/main/data/home_viecmoinhat.json');
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
