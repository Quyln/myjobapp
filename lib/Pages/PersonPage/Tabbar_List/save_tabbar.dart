import 'package:flutter/material.dart';
import 'package:myjobapp/Classes/jobs_class.dart';
import 'package:myjobapp/Classes/user_class.dart';
import 'package:myjobapp/Provider/get_jobs_byid_provider.dart';
import 'package:provider/provider.dart';
import '../../../utils/colors_texts_style.dart';
import '../../JobsPage/jobs_detail_screen.dart';

class SaveTabbar extends StatefulWidget {
  const SaveTabbar({
    super.key,
    required this.userData,
  });
  final User userData;
  @override
  State<SaveTabbar> createState() => _SaveTabbarState();
}

class _SaveTabbarState extends State<SaveTabbar> {
  List<JobsClass> saveJobsList = [];
  @override
  Widget build(BuildContext context) {
    return Consumer<GetSaveJobsByID>(builder: (context, value, child) {
      value.getJobs(widget.userData.savejobs);
      saveJobsList = value.listJobsByID;
      print(widget.userData.savejobs);
      return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: saveJobsList.length,
          itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, bottom: 10, top: 10),
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          saveJobsList[index].image,
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
                              data: saveJobsList[index],
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
                                  saveJobsList[index].position,
                                  style: tTitle,
                                ),
                                Text(
                                  '${saveJobsList[index].salary} triệu',
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
                                    saveJobsList[index].khuvuctinh,
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
              ));
    });
  }
}
