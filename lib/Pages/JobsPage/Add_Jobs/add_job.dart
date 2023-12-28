import 'package:flutter/material.dart';
import 'package:myjobapp/Classes/component/add_job_class.dart';
import 'package:myjobapp/Classes/jobs_class.dart';
import 'package:myjobapp/Pages/JobsPage/Add_Jobs/add_job_googlemap.dart';
import 'package:myjobapp/Provider/login_get_update_user_provider.dart';
import 'package:myjobapp/utils/colors_texts_style.dart';
import 'package:myjobapp/utils/list_tinh_huyen_cv.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddJobPage extends StatefulWidget {
  const AddJobPage({super.key, required this.alljobdata});
  final List<JobsClass> alljobdata;
  @override
  State<AddJobPage> createState() => _AddJobPageState();
}

class _AddJobPageState extends State<AddJobPage> {
  final _titlecontroller = TextEditingController();
  final _positioncontroller = TextEditingController();
  final _namecontroller = TextEditingController();
  final _motacvcontroller = TextEditingController();
  final _yeucaucvcontroller = TextEditingController();

  Map<String, dynamic> newJobData = {'khuvuctinh': 'Hồ Chí Minh'};
  List<String> motacv = [];
  List<String> yeucaucv = [];
  String latitude = '';
  String longitude = '';
  postCreateJob(Map<String, dynamic> requestBody) async {
    var url = Uri.parse('http://103.176.251.70:100/jobs/');
    var response = await http.post(url, body: requestBody);
    if (response.statusCode == 201) {
      print('post thanh cong');
      return true;
    } else {
      print('post that bai');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GetUserProvider>(
      create: (context) {
        return GetUserProvider();
      },
      child: Consumer<GetUserProvider>(
        builder: (context, value, child) {
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 45,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  )),
              backgroundColor: Colors.white,
              title: const Text(
                'TẠO BÀI ĐĂNG',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 16),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(value.user.avatar),
                  ),
                ),
              ],
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        //position
                        margin: const EdgeInsets.only(top: 10),
                        //title
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 10),
                        width: 300,
                        height: 40,
                        decoration: const BoxDecoration(
                            color: Colors.black12,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: TextField(
                          maxLength: 40,
                          onChanged: (value) {
                            setState(() {
                              newJobData['position'] = value;
                            });
                          },
                          textAlign: TextAlign.start,
                          textAlignVertical: TextAlignVertical.center,
                          style: tnormal,
                          controller: _positioncontroller,
                          decoration: const InputDecoration(
                              hintText: 'Vị trí tuyển dụng',
                              border: InputBorder.none,
                              counterText: '',
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 10)),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        //salary
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 35,
                        width: 300,
                        decoration: const BoxDecoration(
                            color: Colors.black12,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Row(
                          children: [
                            Expanded(
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                    menuMaxHeight: 200,
                                    borderRadius: BorderRadius.circular(25),
                                    value: newJobData['salary'],
                                    onChanged: (value) {
                                      setState(() {
                                        newJobData['salary'] = value;
                                      });
                                    },
                                    isExpanded: true,
                                    hint: const Text('Chọn mức lương'),
                                    style: tnormal,
                                    items: mucluong
                                        .map((e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(
                                              e,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black),
                                            )))
                                        .toList()),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        //kv Tinh va Huyen
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            height: 35,
                            width: 145,
                            decoration: const BoxDecoration(
                                color: Colors.black12,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Row(
                              children: [
                                Expanded(
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                        menuMaxHeight: 200,
                                        borderRadius: BorderRadius.circular(25),
                                        value: newJobData['khuvuctinh'],
                                        onChanged: (value) {
                                          setState(() {
                                            newJobData['khuvuctinh'] = value;
                                            newJobData['khuvuchuyen'] = null;
                                          });
                                        },
                                        isExpanded: true,
                                        hint: const Text('Tỉnh'),
                                        style: tnormal,
                                        items: listKvTinh
                                            .map((e) => DropdownMenuItem(
                                                value: e['name'],
                                                child: Text(
                                                  e['name']!,
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black),
                                                )))
                                            .toList()),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            height: 35,
                            width: 145,
                            decoration: const BoxDecoration(
                                color: Colors.black12,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Row(
                              children: [
                                Expanded(
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                        menuMaxHeight: 200,
                                        borderRadius: BorderRadius.circular(25),
                                        value: newJobData['khuvuchuyen'],
                                        onChanged: (value) {
                                          setState(() {
                                            newJobData['khuvuchuyen'] = value;
                                          });
                                        },
                                        isExpanded: true,
                                        hint: const Text('Quận/Huyện'),
                                        style: tnormal,
                                        items: listKvHuyentheoTinh[
                                                newJobData['khuvuctinh']]!
                                            .map((i) => DropdownMenuItem(
                                                value: i,
                                                child: Text(
                                                  i,
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black),
                                                )))
                                            .toList()),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const MapScreen()))
                              .then((value) {
                            setState(() {
                              latitude = value;
                            });
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(top: 10, bottom: 10),
                          height: 35,
                          width: 300,
                          decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(Icons.location_on_outlined),
                                latitude.isEmpty
                                    ? const Text(
                                        'Nhấp để chọn định vị trên bản đồ')
                                    : const Text('Đã lưu vị trí')
                              ]),
                        ),
                      ),
                      Container(
                        //name
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 35,
                        width: 300,
                        decoration: const BoxDecoration(
                            color: Colors.black12,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: TextField(
                          readOnly: true,
                          textAlign: TextAlign.center,
                          style: tnormal,
                          controller: _namecontroller,
                          decoration: InputDecoration(
                              hintText: value.user.companyname,
                              border: InputBorder.none),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        //motacv
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 10),
                        width: 300,
                        decoration: const BoxDecoration(
                            color: Colors.black12,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              motacv.clear();
                              motacv.add(value);
                              newJobData['motacv'] = List<String>.from(motacv);
                            });
                          },
                          textAlign: TextAlign.start,
                          textAlignVertical: TextAlignVertical.center,
                          style: tnormal,
                          maxLines: 5,
                          maxLength: 200,
                          controller: _motacvcontroller,
                          decoration: const InputDecoration(
                              hintText:
                                  'Mô tả công việc\n(Nhập cách nhau bằng dấu chấm ".")\nVD: Mô tả 1. Mô tả 2. v.vv',
                              border: InputBorder.none),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        //yeucaucv
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 10),
                        width: 300,
                        decoration: const BoxDecoration(
                            color: Colors.black12,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              yeucaucv.clear();
                              yeucaucv.add(value);
                              newJobData['yeucaucv'] =
                                  List<String>.from(yeucaucv);
                            });
                          },
                          textAlign: TextAlign.start,
                          textAlignVertical: TextAlignVertical.center,
                          style: tnormal,
                          maxLines: 5,
                          maxLength: 200,
                          controller: _yeucaucvcontroller,
                          decoration: const InputDecoration(
                              hintText:
                                  'Yêu cầu\n(Nhập cách nhau bằng dấu chấm ".")\nVD: Yêu cầu 1. Yêu cầu 2. v.vv',
                              border: InputBorder.none),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        //Dang Bai button
                        onTap: () async {
                          if (newJobData['motacv'] != null &&
                              newJobData['yeucaucv'] != null &&
                              newJobData['position'] != null &&
                              newJobData['khuvuchuyen'] != null &&
                              newJobData['khuvuctinh'] != null &&
                              newJobData['salary'] != null) {
                            SharedPreferences pref =
                                await SharedPreferences.getInstance();
                            String? jobLatitude =
                                await pref.getString('creJobLat');
                            String? jobLongitude =
                                await pref.getString('creJobLong');
                            if (jobLatitude != null && jobLongitude != null) {
                              latitude = jobLatitude;
                              longitude = jobLongitude;
                            }
                            AddJobDto newJob = AddJobDto(
                                title: newJobData['title'],
                                user: value.user.id,
                                motacv: newJobData['motacv'].join(','),
                                yeucaucv: newJobData['yeucaucv'].join(','),
                                position: newJobData['position'],
                                image: '',
                                khuvuchuyen: newJobData['khuvuchuyen'],
                                khuvuctinh: newJobData['khuvuctinh'],
                                latitude: latitude,
                                longitude: longitude,
                                salary: newJobData['salary'],
                                tencty: value.user.companyname,
                                logocty: '');
                            Map<String, dynamic> requestBody = newJob.toJson();
                            bool result = await postCreateJob(requestBody);
                            if (result == true) {
                              _titlecontroller.clear();
                              _positioncontroller.clear();
                              _namecontroller.clear();
                              _motacvcontroller.clear();
                              _yeucaucvcontroller.clear();
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      content: Text(
                                          'Đăng bài tuyển dụng thành công ')));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      content: Text(
                                          'Đăng bài thất bại. Vui lòng kiểm tra lại thông tin hoặc đường truyền kết nối')));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    content: Text(
                                        'Vui lòng điền đầy đủ thông tin khi đăng bài')));
                          }
                        },
                        child: Container(
                          height: 50,
                          width: 130,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.purple),
                          child: const Center(
                            child: Text(
                              'ĐĂNG BÀI',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
