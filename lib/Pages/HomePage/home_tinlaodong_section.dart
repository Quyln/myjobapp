import 'package:carousel_slider/carousel_slider.dart';
import 'package:myjobapp/Provider/home_list_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:flutter/material.dart';
import '../../utils/colors_texts_style.dart';

class TinlaodongHSec extends StatefulWidget {
  const TinlaodongHSec({super.key});

  @override
  State<TinlaodongHSec> createState() => _TinlaodongHSecState();
}

class _TinlaodongHSecState extends State<TinlaodongHSec> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HTinlaodongPro>(
      create: (context) {
        return HTinlaodongPro();
      },
      child: Consumer<HTinlaodongPro>(
        builder: (context, value, child) {
          return CarouselSlider.builder(
              itemCount: value.tinLaoDongdata.length,
              itemBuilder: (context, index, _) {
                return Container(
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(value.tinLaoDongdata[index].image),
                    ),
                  ),
                  child: InkWell(
                    onTap: () {
                      launchUrlString(value.tinLaoDongdata[index].link);
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
                            value.tinLaoDongdata[index].title,
                            style: tTitle,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Image.network(
                            value.tinLaoDongdata[index].author,
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
        },
      ),
    );
  }
}
