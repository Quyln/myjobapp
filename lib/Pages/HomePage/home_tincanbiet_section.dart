import 'package:carousel_slider/carousel_slider.dart';
import 'package:myjobapp/Provider/home_list_provider.dart';
import 'package:myjobapp/utils/colors_texts_style.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:flutter/material.dart';

class TincanbietHSec extends StatefulWidget {
  const TincanbietHSec({super.key});

  @override
  State<TincanbietHSec> createState() => _TincanbietHSecState();
}

class _TincanbietHSecState extends State<TincanbietHSec> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HtincanbietPro>(
      create: (context) {
        return HtincanbietPro();
      },
      child: Consumer<HtincanbietPro>(
        builder: (context, value, child) {
          return CarouselSlider.builder(
              itemCount: value.tinCanBietdata.length,
              itemBuilder: (context, index, _) {
                return Container(
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(value.tinCanBietdata[index].image),
                    ),
                  ),
                  child: InkWell(
                    onTap: () {
                      launchUrlString(value.tinCanBietdata[index].link);
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
                            value.tinCanBietdata[index].title,
                            style: tTitle,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Image.network(
                            value.tinCanBietdata[index].author,
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
                  height: 170,
                  aspectRatio: 16 / 9,
                  enableInfiniteScroll: false,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 7)));
        },
      ),
    );
  }
}
