import 'package:flutter/material.dart';
import 'package:myjobapp/Classes/home_jobs_class.dart';
import 'package:myjobapp/Provider/upload_toppics_provider.dart';
import 'package:myjobapp/utils/colors_texts_style.dart';
import 'package:myjobapp/utils/list_tinh_huyen_cv.dart';
import 'package:provider/provider.dart';

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
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UpdatedataToGit>(
      create: (context) {
        return UpdatedataToGit();
      },
      child: Consumer<UpdatedataToGit>(builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
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
                  fontSize: 18),
            ),
            actions: const [
              Padding(
                padding: EdgeInsets.only(right: 15),
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,
                  backgroundImage: avatar,
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      //title
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 10),
                      width: 300,
                      decoration: const BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            newJobData['title'] = value;
                          });
                        },
                        style: tnormal,
                        maxLength: 50,
                        maxLines: 2,
                        controller: _titlecontroller,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: const InputDecoration(
                            hintText: 'Tiêu đề', border: InputBorder.none),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      //position
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: 40,
                      width: 300,
                      decoration: const BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: TextField(
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
                            border: InputBorder.none),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      //salary
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: 40,
                      width: 300,
                      decoration: const BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
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
                          height: 40,
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
                          width: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          height: 40,
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
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      //name
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: 40,
                      width: 300,
                      decoration: const BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            newJobData['name'] = value;
                          });
                        },
                        textAlign: TextAlign.start,
                        textAlignVertical: TextAlignVertical.center,
                        style: tnormal,
                        controller: _namecontroller,
                        decoration: const InputDecoration(
                            hintText: 'Tên công ty', border: InputBorder.none),
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
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            motacv.add(value);
                            newJobData['motacv'] = motacv;
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
                                'Mô tả công việc\n(Nhập cách nhau bằng dấu phẩy ",")\nVD: Kỹ năng A,Kỹ năng B,...',
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
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            yeucaucv.add(value);
                            newJobData['yeucaucv'] = yeucaucv;
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
                                'Yêu cầu\n(Nhập cách nhau bằng dấu phẩy ",")\nVD: Tỷ mỷ,Tận tâm,..',
                            border: InputBorder.none),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      //Dang Bai button
                      onTap: () {
                        if (newJobData['motacv'] != null &&
                            newJobData['yeucaucv'] != null &&
                            newJobData['position'] != null &&
                            newJobData['khuvuchuyen'] != null &&
                            newJobData['khuvuctinh'] != null &&
                            newJobData['salary'] != null &&
                            newJobData['name'] != null) {
                          JobsClass newJob = JobsClass(
                              motacv: newJobData['motacv'],
                              id: '',
                              yeucaucv: newJobData['yeucaucv'],
                              date: '',
                              position: newJobData['position'],
                              image: '',
                              khuvuchuyen: newJobData['khuvuchuyen'],
                              khuvuctinh: newJobData['khuvuctinh'],
                              salary: newJobData['salary'],
                              tencty: newJobData['name'],
                              logocty: '');

                          final addjob = value.updateDataOnGitHub(newJob);
                          addjob;
                          _titlecontroller.clear();
                          _positioncontroller.clear();
                          _namecontroller.clear();
                          _motacvcontroller.clear();
                          _yeucaucvcontroller.clear();
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              behavior: SnackBarBehavior.floating,
                              content: Text(
                                  'Đăng thành công, bài của bạn đang được xét duyệt')));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
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
      }),
    );
  }
}
