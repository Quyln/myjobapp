import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myjobapp/Classes/home_jobs_class.dart';
import 'package:http/http.dart' as http;

class UploadTopPro extends ChangeNotifier {
  void addtoppictoJson(JobsClass newJob) async {
    final url = Uri.parse(
        'https://raw.githubusercontent.com/Quyln/myjobapp/main/data/home_viecmoinhat.json');
    const username = 'Quyln';
    const password = '1111@';
    // final String repository = 'myjobapp';
    // final String filePath = 'data/home_viecmoinhat.json';
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
        print('Thêm dữ liệu thành công');
      } else {
        print('Thêm dữ liệu thất bại');
      }
      notifyListeners();
    }
  }
}

class UpdatedataToGit extends ChangeNotifier {
  void updateDataOnGitHub(JobsClass newJob) async {
    const String username = 'Quyln';
    const String token =
        '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';
    const String repository = 'myjobapp';
    const String filePath = 'data/home_viecmoinhat.json';
    final url = Uri.parse(
        'https://raw.githubusercontent.com/Quyln/myjobapp/main/data/home_viecmoinhat.json');
    final getjson = await http.get(url);
    final List<dynamic> jobList = jsonDecode(getjson.body);
    final Map<String, dynamic> newJobData = newJob.toJson();
    jobList.add(newJobData);
    final newJsonData = jsonEncode(jobList);
    final putUrl = Uri.parse(
        'https://api.github.com/repos/$username/$repository/contents/$filePath');

    final requestBody = json.encode({
      'message': 'Update data',
      'content': base64.encode(utf8.encode(newJsonData)),
    });

    final headers = {
      'Authorization': 'token $token',
      'Content-Type': 'application/json',
    };

    final response =
        await http.put(putUrl, headers: headers, body: requestBody);

    if (response.statusCode == 200) {
      print('Thêm dữ liệu thành công');
    } else {
      print('Thêm dữ liệu thất bại');
    }
  }
}
