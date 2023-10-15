import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../Classes/home_jobs_class.dart';

class JobsProvider extends ChangeNotifier {
  List<JobsClass> alljobdata = [];
  List<JobsClass> filterJobData = [];
  String selectedText = '';
  String kvHuyen = '';
  void getnewlist() async {
    var url = Uri.parse(
        'https://raw.githubusercontent.com/Quyln/myjobapp/main/data/All_jobs_data.json');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> dataList = jsonDecode(response.body);
      alljobdata = dataList.map((e) => JobsClass.fromJson(e)).toList();
      filterJobData = alljobdata;
      notifyListeners();
    }
  }

  void onpresssearch(String selectedText, String kvHuyen) {
    filterJobData = alljobdata.where((element) {
      return element.khuvuctinh == selectedText &&
          element.khuvuchuyen == kvHuyen;
    }).toList();
    notifyListeners();
  }

  JobsProvider() {
    getnewlist();
    onpresssearch(selectedText, kvHuyen);
  }
}
