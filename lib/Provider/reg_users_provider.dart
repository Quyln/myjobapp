import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegUserProvider extends ChangeNotifier {
  void createUser(Map<String, dynamic> user) async {
    var url = Uri.parse('http://localhost:3000/users/');
    var response = await http.post(url, body: user);

    if (response.statusCode == 201) {
      print('tao tk thanh cong');
    } else {
      throw Exception('Tao tk ko thanh cong');
    }
  }
}
