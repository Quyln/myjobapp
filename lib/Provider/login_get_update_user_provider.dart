import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myjobapp/Classes/user_class.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsersProvider extends ChangeNotifier {
  bool loading = false;
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
    savejobs: '',
    appliedjobs: '',
    postedjobs: '',
    token: 1,
    companyname: '',
    companytax: '',
  );
  Future<User> signInUser(String id, String password) async {
    if (loading) {
      const CircularProgressIndicator();
      throw Exception('Đang xử lý đăng nhập');
    }
    loading = true;

    try {
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
    } finally {
      loading = false; // Đánh dấu kết thúc đăng nhập
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
    savejobs: '',
    appliedjobs: '',
    postedjobs: '',
    token: 1,
    companyname: '',
    companytax: '',
  );

  Future<User> getPreGetUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString('userid');
    String? password = prefs.getString('userpassword');

    if (id != null && password != null) {
      var url = Uri.parse('http://103.176.251.70:100/users/signin');
      var response = await http.post(url, body: {
        "id": id,
        "password": password,
      });
      var data = jsonDecode(response.body);
      user = User.fromJson(data);
      notifyListeners();
      return user;
    } else {
      throw Exception('Không có dữ liệu User');
    }
  }

  updateSavejobs(String id, String savejob) async {
    var url = Uri.parse('http://103.176.251.70:100/users/$id');
    var response = await http.patch(url, body: {"savejobs": savejob});

    if (response.statusCode == 200) {
      print('Việc làm đã được lưu');
      return true;
    } else {
      throw Exception('Lưu việc làm thất bại, vui lòng kiểm tra lại kết nối !');
    }
  }

  removeSavejobs(String id, String savejob) async {
    var url = Uri.parse('http://103.176.251.70:100/users/$id');
    var response = await http.patch(url, body: {"savejobs": savejob});

    if (response.statusCode == 200) {
      print('Bỏ lưu việc làm này');
    } else {
      throw Exception('Bỏ lưu thất bại, vui lòng kiểm tra lại kết nối !');
    }
  }

  updateAppliedjobs(String id, String appliedjobs) async {
    var url = Uri.parse('http://103.176.251.70:100/users/$id');
    var response = await http.patch(url, body: {"appliedjobs": appliedjobs});

    if (response.statusCode == 200) {
      print(
          'Ứng tuyển thành công, bạn sẽ được liên hệ trong thời gian sớm nhất');
    } else {
      throw Exception('Lưu việc làm thất bại, vui lòng kiểm tra lại kết nối !');
    }
  }

  updatePostedjobs(String id, String postedjobs) async {
    var url = Uri.parse('http://103.176.251.70:100/users/$id');
    var response = await http.patch(url, body: {"postedjobs": postedjobs});

    if (response.statusCode == 200) {
      print('Việc làm đã được lưu');
    } else {
      throw Exception('Lưu việc làm thất bại, vui lòng kiểm tra lại kết nối !');
    }
  }

  updatePassword(String id, String currentPass, String newPass) async {
    var url = Uri.parse('http://103.176.251.70:100/users/$id');
    var response = await http
        .patch(url, body: {"password": currentPass, "newpassword": newPass});

    if (response.statusCode == 200) {
      print('Đổi mật khẩu thành công');
    } else {
      throw Exception('Đổi mật khẩu thất bại, vui lòng kiểm tra lại kết nối !');
    }
  }

  GetUserProvider() {
    getPreGetUser();
    notifyListeners();
  }
}
