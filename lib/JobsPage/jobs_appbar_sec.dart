import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:app_settings/app_settings.dart';

class JSecAppBar extends StatefulWidget {
  const JSecAppBar({super.key, required this.onpresssearch});
  final Function(String) onpresssearch;

  @override
  State<JSecAppBar> createState() => _JSecAppBarState();
}

class _JSecAppBarState extends State<JSecAppBar> {
  List<String> listkhuvuc = [
    'An Giang',
    'Bắc Giang',
    'Bắc Kạn',
    'Bạc Liêu',
    'Bắc Ninh',
    'Bến Tre',
    'Bình Định',
    'Bình Dương',
    'Bình Phước',
    'Bình Thuận',
    'Cà Mau',
    'Cần Thơ',
    'Cao Bằng',
    'Đà Nẵng',
    'Đắk Lắk',
    'Đắk Nông',
    'Điện Biên',
    'Đồng Nai',
    'Đồng Tháp',
    'Gia Lai',
    'Hà Giang',
    'Hà Nam',
    'Hà Nội',
    'Hà Tĩnh',
    'Hải Dương',
    'Hải Phòng',
    'Hậu Giang',
    'Hồ Chí Minh',
    'Hòa Bình',
    'Huế',
    'Hưng Yên',
    'Khánh Hòa',
    'Kiên Giang',
    'Kon Tum',
    'Lai Châu',
    'Lâm Đồng',
    'Lạng Sơn',
    'Lào Cai',
    'Long An',
    'Nam Định',
    'Nghệ An',
    'Ninh Bình',
    'Ninh Thuận',
    'Phú Thọ',
    'Phú Yên',
    'Quảng Bình',
    'Quảng Nam',
    'Quảng Ngãi',
    'Quảng Ninh',
    'Quảng Trị',
    'Sóc Trăng',
    'Sơn La',
    'Tây Ninh',
    'Thái Bình',
    'Thái Nguyên',
    'Thanh Hóa',
    'Tiền Giang',
    'Trà Vinh',
    'Tuyên Quang',
    'Vũng Tàu',
    'Vĩnh Long',
    'Vĩnh Phúc',
    'Yên Bái'
  ];
  String selectedText = 'Hồ Chí Minh';
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    Map<Permission, PermissionStatus> status = await [
      Permission.location,
      Permission.camera,
      Permission.microphone
    ].request();
    if (status[Permission.location]!.isGranted) {
      print('Thành công vị trí');
    } else if (status[Permission.location]!.isDenied) {
      print('Huỷ');
    } else if (status[Permission.location]!.isPermanentlyDenied) {
      print('Cự tuyệt');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        content: const Text(
          'Định vị đã tắt, bạn có muốn bật lại?',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        action: SnackBarAction(
          label: 'Đến Setting',
          onPressed: () {
            AppSettings.openAppSettings();
          },
        ),
      ));
    }
    if (status[Permission.camera]!.isGranted) {
      print('Thành công Camera');
    } else if (status[Permission.camera]!.isDenied) {
      print('Huỷ');
    } else if (status[Permission.camera]!.isPermanentlyDenied) {
      print('Cự tuyệt');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        content: const Text(
          'Camera đã tắt, bạn có muốn bật lại?',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        action: SnackBarAction(
          label: 'Đến Setting',
          onPressed: () {
            AppSettings.openAppSettings();
          },
        ),
      ));
    }
    if (status[Permission.microphone]!.isGranted) {
      print('Thành công Micro');
    } else if (status[Permission.microphone]!.isDenied) {
      print('Huỷ');
    } else if (status[Permission.microphone]!.isPermanentlyDenied) {
      print('Cự tuyệt');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        content: const Text(
          'Micro đã tắt, bạn có muốn bật lại?',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        action: SnackBarAction(
          label: 'Đến Setting',
          onPressed: () {
            AppSettings.openAppSettings();
          },
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      pinned: false,
      backgroundColor: Colors.white,
      leading: IconButton(
        onPressed: () {
          showGeneralDialog(
              barrierColor: Colors.black87,
              barrierDismissible: true,
              barrierLabel: 'Chon khu vuc',
              context: context,
              pageBuilder: (context, _, __) => Center(
                    child: Container(
                        height: 400,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration:
                            const BoxDecoration(color: Colors.transparent),
                        child: ListWheelScrollView(
                          physics: const FixedExtentScrollPhysics(),
                          diameterRatio: 1.3,
                          itemExtent: 100,
                          children: listkhuvuc
                              .map((e) => GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedText = e;
                                      });
                                      widget.onpresssearch(selectedText);
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      e,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 50,
                                          color: Colors.white,
                                          decoration: TextDecoration.none),
                                    ),
                                  ))
                              .toList(),
                        )),
                  ));
        },
        icon: const Icon(
          Icons.location_on_outlined,
          size: 30,
          color: Colors.black,
        ),
      ),
      title: const Center(
        child: Text(
          'THỊ TRƯỜNG VIỆC LÀM',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w300, fontSize: 18),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: Colors.white,
        ),
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 15),
          child: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.white,
            backgroundImage: NetworkImage(
                'https://www.premadegraphics.com/img_1/23/Female-Avatar-2.png'),
          ),
        ),
      ],
    );
  }
}
