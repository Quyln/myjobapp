import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UpdateSaveJPro extends ChangeNotifier {
  updateSavejobs(String id, String savejob) async {
    var url = Uri.parse('http://103.176.251.70:100/users/$id');
    var response = await http.patch(url, body: {"savejobs": savejob});

    if (response.statusCode == 200) {
      throw Exception('Việc làm đã được lưu');
    }
    throw Exception('Lưu việc làm thất bại, vui lòng kiểm tra lại kết nối !');
  }

  UpdateSaveJPro() {}
}

class UpdateAppliedJPro extends ChangeNotifier {
  updateAppliedjobs(String id, String appliedjobs) async {
    var url = Uri.parse('http://103.176.251.70:100/users/$id');
    var response = await http.patch(url, body: {"appliedjobs": appliedjobs});

    if (response.statusCode == 200) {
      throw Exception(
          'Ứng tuyển thành công, bạn sẽ được liên hệ trong thời gian sớm nhất');
    }
    throw Exception('Lưu việc làm thất bại, vui lòng kiểm tra lại kết nối !');
  }

  UpdateAppliedJPro() {}
}

class UpdatePostedJPro extends ChangeNotifier {
  updatePostedjobs(String id, String postedjobs) async {
    var url = Uri.parse('http://103.176.251.70:100/users/$id');
    var response = await http.patch(url, body: {"postedjobs": postedjobs});

    if (response.statusCode == 200) {
      throw Exception('Việc làm đã được lưu');
    }
    throw Exception('Lưu việc làm thất bại, vui lòng kiểm tra lại kết nối !');
  }

  UpdatePostedJPro() {}
}
