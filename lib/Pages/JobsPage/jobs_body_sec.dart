import 'package:flutter/material.dart';
import 'package:myjobapp/Classes/home_jobs_class.dart';
import 'package:myjobapp/Pages/JobsPage/jobs_detail_screen.dart';
import 'package:myjobapp/utils/colors_texts_style.dart';

class ShowJSec extends StatefulWidget {
  const ShowJSec({required this.filterJobData, super.key});
  final List<JobsClass> filterJobData;
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
                            widget.filterJobData[index].image,
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
                                data: widget.filterJobData[index],
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
                                    widget.filterJobData[index].position,
                                    style: tTitle,
                                  ),
                                  Text(
                                    widget.filterJobData[index].salary,
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
                                      widget.filterJobData[index].khuvuctinh,
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
                ),
            childCount: widget.filterJobData.length));
  }
}