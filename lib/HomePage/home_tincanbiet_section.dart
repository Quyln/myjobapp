import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:flutter/material.dart';
import 'package:myjobapp/Classes/home_tintuc_class.dart';
import 'package:http/http.dart' as http;

class TincanbietHSec extends StatefulWidget {
  const TincanbietHSec({super.key});

  @override
  State<TincanbietHSec> createState() => _TincanbietHSecState();
}

class _TincanbietHSecState extends State<TincanbietHSec> {
  List<TinTucClass> tinCanBietdata = [];

  @override
  void initState() {
    super.initState();
    getnewlist();
  }

  void getnewlist() async {
    var url = Uri.parse(
        'https://raw.githubusercontent.com/Quyln/myjobapp/main/data/home_tincanbiet.json');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> dataList = jsonDecode(response.body);
      tinCanBietdata = dataList.map((e) => TinTucClass.fromJson(e)).toList();
      setState(() {
        tinCanBietdata;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
        itemCount: tinCanBietdata.length,
        itemBuilder: (context, index, _) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(tinCanBietdata[index].image),
              ),
            ),
            child: InkWell(
              onTap: () {
                launchUrlString(tinCanBietdata[index].link);
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
                      tinCanBietdata[index].title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Image.network(
                      tinCanBietdata[index].author,
                      width: 60,
                      height: 10,
                      fit: BoxFit.fill,
                    ),
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
