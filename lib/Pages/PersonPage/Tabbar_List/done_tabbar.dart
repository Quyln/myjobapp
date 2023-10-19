import 'package:flutter/material.dart';
import 'package:myjobapp/Provider/home_list_provider.dart';
import 'package:provider/provider.dart';

import '../../../utils/colors_texts_style.dart';
import '../../JobsPage/jobs_detail_screen.dart';

class DoneTabbar extends StatefulWidget {
  const DoneTabbar({super.key});

  @override
  State<DoneTabbar> createState() => _DoneTabbarState();
}

class _DoneTabbarState extends State<DoneTabbar> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HviecmoinhatPro>(
      create: (context) => HviecmoinhatPro(),
      child: Consumer<HviecmoinhatPro>(
        builder: (context, value, child) => ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: value.viecMoiNhatdata.length,
            itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 10, top: 10),
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            value.viecMoiNhatdata[index].image,
                          )),
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(25),
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
                                width: 120,
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
                  ),
                )),
      ),
    );
  }
}
