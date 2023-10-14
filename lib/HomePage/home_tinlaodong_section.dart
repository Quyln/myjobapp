import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:flutter/material.dart';
import 'package:myjobapp/Classes/home_tintuc_class.dart';
import 'package:http/http.dart' as http;

import '../utils/colors_texts_style.dart';

class TinlaodongHSec extends StatefulWidget {
  const TinlaodongHSec({super.key});

  @override
  State<TinlaodongHSec> createState() => _TinlaodongHSecState();
}

class _TinlaodongHSecState extends State<TinlaodongHSec> {
  List<TinTucClass> tinLaoDongdata = [];

  @override
  void initState() {
    super.initState();
    getnewlist();
  }

  void getnewlist() async {
    var url = Uri.parse(
        'https://raw.githubusercontent.com/Quyln/myjobapp/main/data/home_tinlaodong.json');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> dataList = jsonDecode(response.body);
      tinLaoDongdata = dataList.map((e) => TinTucClass.fromJson(e)).toList();
      setState(() {
        tinLaoDongdata;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
        itemCount: tinLaoDongdata.length,
        itemBuilder: (context, index, _) {
          return Container(
            width: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(tinLaoDongdata[index].image),
              ),
            ),
            child: InkWell(
              onTap: () {
                launchUrlString(tinLaoDongdata[index].link);
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: const LinearGradient(
                        colors: [Colors.transparent, Colors.black],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      tinLaoDongdata[index].title,
                      style: tTitle,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Image.network(
                      tinLaoDongdata[index].author,
                      width: 60,
                      height: 10,
                      fit: BoxFit.fill,
                    )
                  ],
                ),
              ),
            ),
          );
        },
        options: CarouselOptions(
            height: 170,
            aspectRatio: 16 / 9,
            enableInfiniteScroll: false,
            enlargeCenterPage: true,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 7)));
  }
}
