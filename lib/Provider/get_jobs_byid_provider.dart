import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myjobapp/Classes/jobs_class.dart';

class GetSaveJobsByID extends ChangeNotifier {
  List<JobsClass> listJobsByID = [];

  String ids = '';

  getJobs(String ids) async {
    var url = Uri.parse('http://103.176.251.70:100/jobs/$ids');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> fetchData = jsonDecode(response.body);
      listJobsByID = fetchData.map((e) => JobsClass.fromJson(e)).toList();
      notifyListeners();
    } else {
      throw Exception('Nhận dữ liệu thất bại');
    }
  }

  GetSaveJobsByID() {
    getJobs(ids);
  }
}

class GetAppliedJobsByID extends ChangeNotifier {
  List<JobsClass> listJobsByID = [];

  String ids = '';

  getJobs(String ids) async {
    var url = Uri.parse('http://103.176.251.70:100/jobs/$ids');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> fetchData = jsonDecode(response.body);
      listJobsByID = fetchData.map((e) => JobsClass.fromJson(e)).toList();
      notifyListeners();
    } else {
      throw Exception('Nhận dữ liệu thất bại');
    }
  }

  GetAppliedJobsByID() {
    getJobs(ids);
  }
}

class GetPostedJobsByID extends ChangeNotifier {
  List<JobsClass> listJobsByID = [];
  String idsJobList = '';
  String ids = '';

  getJobs(String ids) async {
    var url = Uri.parse('http://103.176.251.70:100/jobs/$ids');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> fetchData = jsonDecode(response.body);
      listJobsByID = fetchData.map((e) => JobsClass.fromJson(e)).toList();
      notifyListeners();
    } else {
      throw Exception('Nhận dữ liệu thất bại');
    }
  }

  getIdPostedJobs(String creatorId) async {
    var url = Uri.parse('http://103.176.251.70:100/jobs/idjobsbyuser');
    var response = await http.post(url, body: {"user": "${creatorId}"});
    if (response.statusCode == 201) {
      print('Cập nhật danh sách việc của bạn thành công');
      idsJobList = response.body;
      notifyListeners();
    } else {
      throw Exception('Nhận dữ liệu thất bại');
    }
  }

  GetPostedJobsByID() {
    getJobs(ids);
  }
}
