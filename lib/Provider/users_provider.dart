import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myjobapp/Classes/person_class.dart';

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
  );
  Future<User> signInUser(String id, String password) async {
    var url = Uri.parse('http://localhost:3000/users/signin');
    var response = await http.post(url, body: {
      "id": id,
      "password": password,
    });
    if (response.statusCode == 201) {
      var data = jsonDecode(response.body);
      var user = User.fromJson(data);
      return user;
    } else {
      throw Exception('Loi dang nhap');
    }
  }

  UsersProvider() {
    signInUser(id, password);
  }
}
