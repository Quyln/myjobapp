import 'package:flutter/material.dart';
import 'package:myjobapp/Classes/jobs_class.dart';
import 'package:myjobapp/Pages/JobsPage/Add_Jobs/add_job.dart';
import 'package:myjobapp/Provider/login_get_update_user_provider.dart';
import 'package:provider/provider.dart';

import '../../utils/list_tinh_huyen_cv.dart';
import 'Add_Jobs/show_jobs_onmap.dart';

class JSecAppBar extends StatefulWidget {
  const JSecAppBar(
      {super.key, required this.onpresssearch, required this.data});
  final Function(String, String) onpresssearch;
  final List<JobsClass> data;
  @override
  State<JSecAppBar> createState() => _JSecAppBarState();
}

class _JSecAppBarState extends State<JSecAppBar> {
  String selectedText = 'Hồ Chí Minh';
  String kvHuyen = 'Bến Cát';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GetUserProvider>(
      create: (context) {
        return GetUserProvider();
      },
      child: Consumer<GetUserProvider>(
        builder: (context, value, child) {
          return SliverAppBar(
            floating: true,
            pinned: false,
            backgroundColor: Colors.white,
            leading: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: IconButton(
                onPressed: () {
                  showGeneralDialog(
                      barrierColor: Colors.black87,
                      barrierDismissible: true,
                      barrierLabel: 'Chon khu vuc',
                      context: context,
                      pageBuilder: (context, _, __) => Center(
                            child: Container(
                                height: 400,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                decoration: const BoxDecoration(
                                    color: Colors.transparent),
                                child: ListWheelScrollView(
                                  physics: const FixedExtentScrollPhysics(),
                                  diameterRatio: 1.3,
                                  itemExtent: 100,
                                  children: listKvTinh
                                      .map((e) => GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                selectedText = e['name']!;
                                              });
                                              Navigator.pop(context);
                                              showGeneralDialog(
                                                  barrierColor: Colors.black87,
                                                  barrierLabel: 'chon huyen',
                                                  barrierDismissible: true,
                                                  context: context,
                                                  pageBuilder:
                                                      (context, _, __) =>
                                                          Center(
                                                            child: Container(
                                                              height: 400,
                                                              margin: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      20),
                                                              decoration:
                                                                  const BoxDecoration(
                                                                      color: Colors
                                                                          .transparent),
                                                              child:
                                                                  ListWheelScrollView(
                                                                physics:
                                                                    const FixedExtentScrollPhysics(),
                                                                diameterRatio:
                                                                    1.3,
                                                                itemExtent: 100,
                                                                children: listKvHuyentheoTinh[
                                                                        selectedText]!
                                                                    .map((i) =>
                                                                        GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            setState(() {
                                                                              kvHuyen = i;
                                                                              widget.onpresssearch(selectedText, kvHuyen);
                                                                            });
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child:
                                                                              Text(
                                                                            i,
                                                                            style: const TextStyle(
                                                                                fontWeight: FontWeight.w800,
                                                                                fontSize: 40,
                                                                                color: Colors.white,
                                                                                decoration: TextDecoration.none),
                                                                          ),
                                                                        ))
                                                                    .toList(),
                                                              ),
                                                            ),
                                                          ));
                                            },
                                            child: Text(
                                              e['name']!,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 40,
                                                  color: Colors.white,
                                                  decoration:
                                                      TextDecoration.none),
                                            ),
                                          ))
                                      .toList(),
                                )),
                          ));
                },
                icon: const Icon(
                  Icons.search_outlined,
                  size: 30,
                  color: Colors.black,
                ),
              ),
            ),
            title: const Center(
              child: Text(
                'THỊ TRƯỜNG VIỆC LÀM',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 18),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Colors.white,
              ),
            ),
            actions: [
              value.user.position == 'Nhà tuyển dụng'
                  ? Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AddJobPage(
                                    alljobdata: widget.data,
                                  )));
                        },
                        icon: const Icon(
                          Icons.add_circle_outline,
                          color: Colors.black,
                          size: 30,
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ShowJobOnMap(userData: value.user)));
                            },
                            icon: const Icon(
                              Icons.location_on_outlined,
                              color: Colors.black,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
            ],
          );
        },
      ),
    );
  }
}
