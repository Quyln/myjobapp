import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:myjobapp/Classes/home_tintuc_class.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher_string.dart';

class TinNoiBatHSec extends StatefulWidget {
  const TinNoiBatHSec({super.key});

  @override
  State<TinNoiBatHSec> createState() => _TinNoiBatHSecState();
}

class _TinNoiBatHSecState extends State<TinNoiBatHSec> {
  List<TinTucClass> tinNoiBatHomedata = [];

  @override
  void initState() {
    super.initState();
    getnewlist();
  }

  void getnewlist() async {
    var url = Uri.parse(
        'https://raw.githubusercontent.com/Quyln/myjobapp/main/data/home_tinnoibat.json');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> dataList = jsonDecode(response.body);
      tinNoiBatHomedata = dataList.map((e) => TinTucClass.fromJson(e)).toList();
      setState(() {
        tinNoiBatHomedata;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
        itemCount: tinNoiBatHomedata.length,
        itemBuilder: (context, index, _) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(tinNoiBatHomedata[index].image),
              ),
            ),
            child: InkWell(
              onTap: () {
                launchUrlString(tinNoiBatHomedata[index].link);
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
                      tinNoiBatHomedata[index].title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Image.network(
                      tinNoiBatHomedata[index].author,
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
            aspectRatio: 16 / 9,
            enableInfiniteScroll: false,
            enlargeCenterPage: true,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 7)));
  }
}
