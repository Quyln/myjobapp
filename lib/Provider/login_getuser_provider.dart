import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myjobapp/Classes/user_class.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsersProvider extends ChangeNotifier {
  String id = '';
  String password = '';
  User user = User(
    id: '',
    avatar: '',
    fullname: '',
    lastjob: '',
    password: '',
    phone: '',
    position: '',
    token: 1,
    companyname: '',
    companytax: '',
  );
  Future<User> signInUser(String id, String password) async {
    var url = Uri.parse('http://103.176.251.70:100/users/signin');
    var response = await http.post(url, body: {
      "id": id,
      "password": password,
    });
    if (response.statusCode == 201) {
      var data = jsonDecode(response.body);
      user = User.fromJson(data);
      notifyListeners();
      return user;
    } else {
      throw Exception('Lỗi đăng nhập');
    }
  }

  UsersProvider() {
    // signInUser(id, password);
    notifyListeners();
  }
}

class GetUserProvider extends ChangeNotifier {
  User user = User(
    id: '',
    avatar: '',
    fullname: '',
    lastjob: '',
    password: '',
    phone: '',
    position: '',
    token: 1,
    companyname: '',
    companytax: '',
  );

  Future<User> sharePreGetUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user');
    if (userJson != null) {
      user = User.fromJson(jsonDecode(userJson));
      notifyListeners();
      return user;
    } else {
      throw Exception('Không có dữ liệu User');
    }
  }

  GetUserProvider() {
    sharePreGetUser();
    notifyListeners();
  }
}
