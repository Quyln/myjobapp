import 'package:flutter/material.dart';
import 'package:myjobapp/Classes/home_jobs_class.dart';
import 'package:myjobapp/JobsPage/jobs_detail_screen.dart';
import 'package:myjobapp/utils/colors_texts_style.dart';

class ShowJSec extends StatefulWidget {
  const ShowJSec({required this.alljobdata, super.key});
  final List<JobsClass> alljobdata;
  @override
  State<ShowJSec> createState() => _ShowJSecState();
}

class _ShowJSecState extends State<ShowJSec> {
  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
            (context, index) => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            widget.alljobdata[index].image,
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
                                data: widget.alljobdata[index],
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
                                    widget.alljobdata[index].position,
                                    style: tTitle,
                                  ),
                                  Text(
                                    '${widget.alljobdata[index].salary} triệu',
                                    style: const TextStyle(
                                        color: Colors.yellow,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
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
                                        colors: [
                                          Colors.transparent,
                                          Colors.white
                                        ],
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
                                      widget.alljobdata[index].khuvuctinh,
                                      style: const TextStyle(
                                          color: Colors.yellow,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
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
                ),
            childCount: widget.alljobdata.length));
  }
}
