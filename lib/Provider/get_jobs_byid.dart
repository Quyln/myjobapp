import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myjobapp/Classes/jobs_class.dart';

class GetJobsByID extends ChangeNotifier {
  List<JobsClass> listJobsByID = [];

  String ids = '1700207895887,1700162646118,1700301992588';

  getJobs(String ids) async {
    var url = Uri.parse('http://103.176.251.70:100/jobs/$ids');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> fetchData = jsonDecode(response.body);
      listJobsByID = fetchData.map((e) => JobsClass.fromJson(e)).toList();
      notifyListeners();
    }
  }

  GetJobsByID() {
    getJobs(ids);
  }
}
