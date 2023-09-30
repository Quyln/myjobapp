import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:myjobapp/Classes/home_tintuc_class.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher_string.dart';

class TinNoiBatSec extends StatefulWidget {
  const TinNoiBatSec({super.key});

  @override
  State<TinNoiBatSec> createState() => _TinNoiBatSecState();
}

class _TinNoiBatSecState extends State<TinNoiBatSec> {
  final _controller = PageController();
  List<dynamic> tinNoiBatHomedata = [];

  @override
  void initState() {
    super.initState();
    getnewlist();
  }

  void getnewlist() async {
    var url = Uri.parse(
        'https://raw.githubusercontent.com/Quyln/myjobapp/main/data/home_tinnoibat.json');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> dataList = jsonDecode(response.body);
      tinNoiBatHomedata = dataList.map((e) => TinTucClass.fromJson(e)).toList();
      setState(() {
        tinNoiBatHomedata;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controller,
      scrollDirection: Axis.horizontal,
      children: tinNoiBatHomedata
          .map(
            (e) => Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: InkWell(
                  onTap: () {
                    launchUrlString(e.link);
                  },
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fitWidth,
                                image: NetworkImage(e.image)),
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: const [
                              BoxShadow(
                                  blurRadius: 2,
                                  blurStyle: BlurStyle.outer,
                                  color: Color.fromRGBO(0, 0, 0, 0.4))
                            ]),
                      ),
                      Container(
                        height: 40,
                        width: 270,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(25),
                                topLeft: Radius.circular(25))),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          child: Text(
                            e.title,
                            style: const TextStyle(fontSize: 17),
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )
                    ],
                  ),
                )),
          )
          .toList(),
    );
  }
}
