import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myjobapp/Classes/home_jobs_class.dart';
import 'package:myjobapp/utils/colors_texts_style.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

class JobsDetailScr extends StatefulWidget {
  const JobsDetailScr({required this.data, super.key});

  final JobsClass data;

  @override
  State<JobsDetailScr> createState() => _JobsDetailScrState();
}

class _JobsDetailScrState extends State<JobsDetailScr> {
  bool savejob = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: maunen,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 10, left: 20, right: 20, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(8)),
                      child: const Icon(Icons.arrow_back),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showGeneralDialog(
                          barrierColor: Colors.black45,
                          barrierDismissible: true,
                          barrierLabel: 'share job',
                          context: context,
                          pageBuilder: (context, _, __) => Center(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  height: 380,
                                  width: 310,
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30))),
                                  child: Column(children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    QrImageView(
                                        // tao ma qr code
                                        version: QrVersions.auto,
                                        size: 200,
                                        data:
                                            'https://www.youtube.com/clip/UgkxF00z2lyZjE9JCsEdLVP8TtqV6jlIAAyy'),
                                    const Text(
                                      'Link to share',
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                          color: Colors.black,
                                          fontSize: 18),
                                    ),
                                    Container(
                                        //link chia se
                                        padding: const EdgeInsets.all(10),
                                        height: 40,
                                        width: 250,
                                        decoration: BoxDecoration(
                                            color: Colors.black12,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: GestureDetector(
                                          onTap: () {
                                            const String textCopy =
                                                'https://www.youtube.com/clip/UgkxF00z2lyZjE9JCsEdLVP8TtqV6jlIAAyy';
                                            Clipboard.setData(
                                                const ClipboardData(
                                                    text: textCopy));
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    behavior: SnackBarBehavior
                                                        .floating,
                                                    content: Text(
                                                      'Đã sao chép link',
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                    )));
                                          },
                                          child: const Row(
                                            children: [
                                              Expanded(
                                                child: Center(
                                                  child: Text(
                                                    'https://www.youtube.com/clip/UgkxF00z2lyZjE9JCsEdLVP8TtqV6jlIAAyy',
                                                    style: TextStyle(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        decoration:
                                                            TextDecoration.none,
                                                        color: Colors.black,
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                ),
                                              ),
                                              Icon(Icons.copy_all)
                                            ],
                                          ),
                                        )),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      //chia se qua mang xa hoi
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Share.share(
                                                'https://www.facebook.com/sharer/sharer.php?u=https://www.youtube.com/clip/UgkxF00z2lyZjE9JCsEdLVP8TtqV6jlIAAyy');
                                          },
                                          child: SizedBox(
                                            height: 40,
                                            width: 40,
                                            child: Image.network(
                                              'https://pngimg.com/uploads/facebook_logos/facebook_logos_PNG19757.png',
                                              height: 40,
                                              width: 40,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Share.share(
                                                'https://www.instagram.com/share?url=https://www.youtube.com/clip/UgkxF00z2lyZjE9JCsEdLVP8TtqV6jlIAAyy');
                                          },
                                          child: SizedBox(
                                            height: 40,
                                            width: 40,
                                            child: Image.network(
                                              'https://imagepng.org/wp-content/uploads/2017/08/instagram-icone-icon-2.png',
                                              height: 40,
                                              width: 40,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Share.share(
                                                'https://zalo.me/share?text=https://www.youtube.com/clip/UgkxF00z2lyZjE9JCsEdLVP8TtqV6jlIAAyy');
                                          },
                                          child: SizedBox(
                                            height: 40,
                                            width: 40,
                                            child: Image.network(
                                              'https://cdn.freebiesupply.com/logos/large/2x/zalo-1-logo-png-transparent.png',
                                              height: 40,
                                              width: 40,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ]),
                                ),
                              ));
                    },
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(8)),
                      child: const Icon(Icons.share),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 200,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  widget.data.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.data.position,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.data.tencty,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Icon(
                    Icons.location_on_outlined,
                    size: 17,
                  ),
                  Text('${widget.data.khuvuchuyen},${widget.data.khuvuctinh}'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          'Mô tả công việc:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var i = 0; i < widget.data.motacv.length; i++)
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                children: [
                                  Container(
                                    height: 6,
                                    width: 6,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black54),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Flexible(
                                    child: Text(
                                      widget.data.motacv[i],
                                      style: const TextStyle(
                                          fontSize: 15, color: Colors.black54),
                                    ),
                                  ),
                                ],
                              ),
                            )
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          'Yêu cầu:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var i = 0; i < widget.data.yeucaucv.length; i++)
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                children: [
                                  Container(
                                    height: 6,
                                    width: 6,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black54),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Flexible(
                                    child: Text(
                                      widget.data.yeucaucv[i],
                                      style: const TextStyle(
                                          fontSize: 15, color: Colors.black54),
                                    ),
                                  ),
                                ],
                              ),
                            )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20, left: 10, right: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    savejob = !savejob;
                                  });
                                },
                                child: savejob
                                    ? const Icon(Icons.favorite_border_outlined)
                                    : const Icon(
                                        Icons.favorite_rounded,
                                        color: Colors.pink,
                                      )),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                height: 50,
                                width: 160,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(25)),
                                child: const Center(
                                    child: Text(
                                  'ỨNG TUYỂN',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )),
                              ),
                            )
                          ],
                        ),
                      )
                    ]),
              ),
            )
          ],
        )),
      ),
    );
  }
}
