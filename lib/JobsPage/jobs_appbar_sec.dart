import 'package:flutter/material.dart';

class JSecAppBar extends StatefulWidget {
  const JSecAppBar({
    super.key,
    required this.onpresssearch,
  });
  final Function() onpresssearch;

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
  int selectedPosition = 0;

  @override
  void initState() {
    super.initState();
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
                          children: listkhuvuc
                              .map((e) => GestureDetector(
                                    onTap: () {},
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
                          itemExtent: 100,
                          onSelectedItemChanged: (value) {
                            setState(() {
                              selectedPosition = value;
                            });
                          },
                        )),
                  ));
        },
        icon: const Icon(
          Icons.search,
          size: 30,
          color: Colors.black,
        ),
      ),
      title: const Text(
        'THỊ TRƯỜNG VIỆC LÀM',
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.w300, fontSize: 18),
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
