import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myjobapp/Classes/home_jobs_class.dart';
import 'package:http/http.dart' as http;

class ViecmoinhatHomeSec extends StatefulWidget {
  const ViecmoinhatHomeSec({super.key});

  @override
  State<ViecmoinhatHomeSec> createState() => _TinNoiBatSecState();
}

class _TinNoiBatSecState extends State<ViecmoinhatHomeSec> {
  final _controller = PageController();
  List<dynamic> tinNoiBatHomedata = [];

  @override
  void initState() {
    super.initState();
    getnewlist();
  }

  void getnewlist() async {
    var url = Uri.parse(
        'https://raw.githubusercontent.com/Quyln/myjobapp/main/data/home_viecmoinhat.json');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> dataList = jsonDecode(response.body);
      tinNoiBatHomedata = dataList.map((e) => JobsClass.fromJson(e)).toList();
      setState(() {
        tinNoiBatHomedata;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controller,
      scrollDirection: Axis.horizontal,
      children: tinNoiBatHomedata
          .map(
            (e) => Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fitWidth,
                              image: NetworkImage(e.image)),
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
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(25),
                              topLeft: Radius.circular(25))),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, top: 10),
                        child: Text(
                          e.title,
                          style: TextStyle(fontSize: 17),
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        height: 37,
                        width: 128,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(25),
                                topLeft: Radius.circular(25))),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          child: Text(
                            e.salary,
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        height: 37,
                        width: 128,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(25),
                                topRight: Radius.circular(25))),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10, top: 10),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              e.khuvuctinh,
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )),
          )
          .toList(),
    );
  }
}
