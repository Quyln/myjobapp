import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:myjobapp/Provider/newlist_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class TinNoiBatHSec extends StatefulWidget {
  const TinNoiBatHSec({super.key});

  @override
  State<TinNoiBatHSec> createState() => _TinNoiBatHSecState();
}

class _TinNoiBatHSecState extends State<TinNoiBatHSec> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HTinnoiboPro>(
      create: (context) {
        return HTinnoiboPro();
      },
      child: Consumer<HTinnoiboPro>(
        builder: (context, value, child) {
          return CarouselSlider.builder(
              itemCount: value.tinNoiBatHomedata.length,
              itemBuilder: (context, index, _) {
                return Container(
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(value.tinNoiBatHomedata[index].image),
                    ),
                  ),
                  child: InkWell(
                    onTap: () {
                      launchUrlString(value.tinNoiBatHomedata[index].link);
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
                            value.tinNoiBatHomedata[index].title,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Image.network(
                            value.tinNoiBatHomedata[index].author,
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
