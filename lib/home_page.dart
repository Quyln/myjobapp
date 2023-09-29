import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(220, 223, 229, 1),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.lightBlueAccent,
                      backgroundImage: NetworkImage(
                          'https://www.premadegraphics.com/img_1/23/Female-Avatar-2.png'),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Trần Khả Như',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text(
                          'Thành Viên',
                          style: TextStyle(
                              fontStyle: FontStyle.normal, fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
                Icon(Icons.search)
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Tin nổi bật',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 180,
            child: PageView(
              controller: _controller,
              scrollDirection: Axis.horizontal,
              children: [
                Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: Stack(
                      alignment: AlignmentDirectional.bottomStart,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fitWidth,
                                  image: NetworkImage(
                                      'https://media-cdn-v2.laodong.vn/storage/newsportal/2023/9/29/1247947/Uy-Ban-Quan-Ly-Von.jpg?w=660')),
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: const [
                                BoxShadow(
                                    blurRadius: 2,
                                    blurStyle: BlurStyle.outer,
                                    color: Color.fromRGBO(0, 0, 0, 0.4))
                              ]),
                        ),
                        Container(
                          height: 40,
                          width: 270,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(25),
                                  bottomLeft: Radius.circular(25))),
                          child: const Padding(
                            padding: const EdgeInsets.only(left: 10, top: 10),
                            child: Text(
                              'Dấu ấn "siêu uỷ ban" sau 5 năm quản lý khối tài sản hơn 2.360 nghìn tỉ đồng',
                              style: TextStyle(fontSize: 17),
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )
                      ],
                    )),
              ],
            ),
          )
        ],
      )),
    );
  }
}
