import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myjobapp/Classes/component/list_users_search.dart';

class FilterUserSearchPro extends ChangeNotifier {
  List<UserForSearch> listUsers = [];

  void getUserForSearch() async {
    var url = Uri.parse('http://103.176.251.70:100/users/useridlist');
    var respone = await http.get(url);

    if (respone.statusCode == 200) {
      List<dynamic> dataList = jsonDecode(respone.body);
      listUsers = dataList.map((e) => UserForSearch.fromJson(e)).toList();
      notifyListeners();
    }
  }

  FilterUserSearchPro() {
    getUserForSearch();
  }
}
