import 'package:flutter/material.dart';
import 'package:myjobapp/Classes/home_tintuc_class.dart';
import 'package:myjobapp/utils/colors_texts_style.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ShowNSec extends StatefulWidget {
  const ShowNSec({super.key, required this.data, required this.randomtoppics});
  final List<TinTucClass> data;
  final Function randomtoppics;
  @override
  State<ShowNSec> createState() => _ShowNSecState();
}

class _ShowNSecState extends State<ShowNSec> {
  @override
  Widget build(BuildContext context) {
    final randomnews = widget.randomtoppics;
    randomnews();
    return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Container(
          height: 180,
          decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  widget.data[index].image,
                )),
            color: Colors.black,
            borderRadius: BorderRadius.circular(25),
          ),
          child: InkWell(
            onTap: () {
              launchUrlString(widget.data[index].link);
            },
            child: Container(
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
                        widget.data[index].title,
                        style: tTitle,
                      ),
                      Image.network(
                        widget.data[index].author,
                        height: 15,
                        width: 60,
                        fit: BoxFit.contain,
                      )
                    ]),
              ),
            ),
          ),
        ),
      );
    }, childCount: widget.data.length));
  }
}
