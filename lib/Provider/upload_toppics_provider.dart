import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myjobapp/Classes/home_jobs_class.dart';
import 'package:http/http.dart' as http;

class UploadTopPro extends ChangeNotifier {
  void addtoppictoJson(JobsClass newJob) async {
    final url = Uri.parse(
        'https://raw.githubusercontent.com/Quyln/myjobapp/main/data/home_viecmoinhat.json');
    const username = 'id';
    const password = 'pass@';
    final respone = await http.get(url);
    if (respone.statusCode == 200) {
      final List<dynamic> jobList = jsonDecode(respone.body);
      final Map<String, dynamic> newJobData = newJob.toJson();
      jobList.add(newJobData);
      final newJsonData = jsonEncode(jobList);
      final putResponse = await http.put(
        url,
        headers: {
          'Authorization':
              'Basic ' + base64Encode(utf8.encode('$username:$password')),
          'Content-Type': 'application/json',
        },
        body: newJsonData,
      );

      if (putResponse.statusCode == 200) {
        print('Data added to JSON on GitHub successfully');
      } else {
        print('Failed to add data to JSON on GitHub');
      }
      notifyListeners();
    }
  }
}
