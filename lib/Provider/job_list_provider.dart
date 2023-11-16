import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:myjobapp/Classes/jobs_class.dart';

class JobsProvider extends ChangeNotifier {
  List<JobsClass> alljobdata = [];
  List<JobsClass> filterJobData = [];
  String selectedText = '';
  String kvHuyen = '';
  void getnewlist() async {
    var url = Uri.parse('http://103.176.251.70:80/jobs/');
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

  Future<Position> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    return position;
  }

  JobsProvider() {
    getnewlist();
    onpresssearch(selectedText, kvHuyen);
    getCurrentLocation();
  }
}
