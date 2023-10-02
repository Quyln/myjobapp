import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:myjobapp/Classes/home_jobs_class.dart';
import 'package:http/http.dart' as http;

import '../JobsPage/jobs_detail_screen.dart';

class ViecmoinhatHSec extends StatefulWidget {
  const ViecmoinhatHSec({super.key});

  @override
  State<ViecmoinhatHSec> createState() => _ViecmoinhatHSecState();
}

class _ViecmoinhatHSecState extends State<ViecmoinhatHSec> {
  List<JobsClass> viecMoiNhatdata = [];

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
      viecMoiNhatdata = dataList.map((e) => JobsClass.fromJson(e)).toList();
      setState(() {
        viecMoiNhatdata;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
        itemCount: viecMoiNhatdata.length,
        itemBuilder: (context, index, _) {
          return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(viecMoiNhatdata[index].image),
              ),
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => JobsDetailScr(
                        data: viecMoiNhatdata[index],
                      ),
                    ));
              },
              child: Stack(children: [
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    gradient: const LinearGradient(
                        colors: [Colors.transparent, Colors.black],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            viecMoiNhatdata[index].position,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                        ]),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: 40,
                    width: 150,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [Colors.transparent, Colors.red],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter),
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(25)),
                    child: Center(
                      child: Text(
                        viecMoiNhatdata[index].salary + '/Ngày',
                        style: const TextStyle(
                            color: Colors.yellow,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    height: 40,
                    width: 140,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.transparent, Colors.white],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter),
                        color: Colors.red,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            topRight: Radius.circular(25))),
                    child: Center(
                      child: Text(
                        viecMoiNhatdata[index].khuvuctinh,
                        style: const TextStyle(
                            color: Colors.yellow,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  ),
                )
              ]),
            ),
          );
        },
        options: CarouselOptions(
            aspectRatio: 16 / 9,
            enableInfiniteScroll: false,
            enlargeCenterPage: true,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 7)));
  }
}
