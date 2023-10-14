import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:myjobapp/Provider/Home_list_provider.dart';
import 'package:provider/provider.dart';
import '../JobsPage/jobs_detail_screen.dart';
import '../../utils/colors_texts_style.dart';

class ViecmoinhatHSec extends StatefulWidget {
  const ViecmoinhatHSec({super.key});

  @override
  State<ViecmoinhatHSec> createState() => _ViecmoinhatHSecState();
}

class _ViecmoinhatHSecState extends State<ViecmoinhatHSec> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HviecmoinhatPro>(
      create: (context) {
        return HviecmoinhatPro();
      },
      child: Consumer<HviecmoinhatPro>(
        builder: (context, value, child) {
          return CarouselSlider.builder(
              itemCount: value.viecMoiNhatdata.length,
              itemBuilder: (context, index, _) {
                return Container(
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(value.viecMoiNhatdata[index].image),
                    ),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => JobsDetailScr(
                              data: value.viecMoiNhatdata[index],
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
                                  value.viecMoiNhatdata[index].position,
                                  style: tTitle,
                                ),
                                Text(
                                  '${value.viecMoiNhatdata[index].salary} triệu',
                                  style: const TextStyle(
                                      color: Colors.yellow,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                              ]),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Column(
                          children: [
                            Container(
                              height: 30,
                              width: 135,
                              decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [Colors.black54, Colors.red],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter),
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(25),
                                      topRight: Radius.circular(25))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    size: 20,
                                    color: Colors.yellow,
                                  ),
                                  Text(
                                    value.viecMoiNhatdata[index].khuvuctinh,
                                    style: const TextStyle(
                                        color: Colors.yellow,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
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
