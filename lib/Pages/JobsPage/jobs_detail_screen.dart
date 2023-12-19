import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myjobapp/Classes/component/applier_job_class.dart';
import 'package:myjobapp/Classes/jobs_class.dart';
import 'package:myjobapp/Classes/user_class.dart';
import 'package:myjobapp/Provider/login_getuser_provider.dart';
import 'package:myjobapp/utils/colors_texts_style.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;

class JobsDetailScr extends StatefulWidget {
  const JobsDetailScr({required this.data, super.key, required this.userData});

  final JobsClass data;
  final User userData;

  @override
  State<JobsDetailScr> createState() => _JobsDetailScrState();
}

class _JobsDetailScrState extends State<JobsDetailScr> {
  bool savejob = false;
  bool loading = false;
  bool appliedjob = false;
  @override
  void initState() {
    super.initState();
    String savejobUser = widget.userData.savejobs;
    String appliedjobUser = widget.userData.appliedjobs;

    checkSaveJobs(widget.data.id, savejobUser);
    checkAppliedJobs(widget.data.id, appliedjobUser);
  }

  bool checkSaveJobs(String id, String userSavejob) {
    List<String> savejobList = userSavejob.split(',');

    if (savejobList.contains(id)) {
      setState(() {
        savejob = true;
      });
      return true;
    } else {
      setState(() {
        savejob = false;
      });
      return false;
    }
  }

  bool checkAppliedJobs(String id, String userAppliedjob) {
    List<String> appliedjobList = userAppliedjob.split(',');

    if (appliedjobList.contains(id)) {
      setState(() {
        appliedjob = true;
      });
      return true;
    } else {
      setState(() {
        appliedjob = false;
      });
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GetUserProvider>(
      create: (context) {
        return GetUserProvider();
      },
      child: Consumer<GetUserProvider>(
        builder: (context, value, child) {
          return Scaffold(
              backgroundColor: maunen,
              body: Stack(
                children: [
                  SingleChildScrollView(
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 20),
                                              height: 380,
                                              width: 310,
                                              decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.all(
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
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      decoration:
                                                          TextDecoration.none,
                                                      color: Colors.black,
                                                      fontSize: 18),
                                                ),
                                                Container(
                                                    //link chia se
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    height: 40,
                                                    width: 250,
                                                    decoration: BoxDecoration(
                                                        color: Colors.black12,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15)),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        const String textCopy =
                                                            'https://www.youtube.com/clip/UgkxF00z2lyZjE9JCsEdLVP8TtqV6jlIAAyy';
                                                        Clipboard.setData(
                                                            const ClipboardData(
                                                                text:
                                                                    textCopy));
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                const SnackBar(
                                                                    behavior:
                                                                        SnackBarBehavior
                                                                            .floating,
                                                                    content:
                                                                        Text(
                                                                      'Đã sao chép link',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              20),
                                                                    )));
                                                      },
                                                      child: const Row(
                                                        children: [
                                                          Expanded(
                                                            child: Center(
                                                              child: Text(
                                                                'https://www.youtube.com/clip/UgkxF00z2lyZjE9JCsEdLVP8TtqV6jlIAAyy',
                                                                style: TextStyle(
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    decoration:
                                                                        TextDecoration
                                                                            .none,
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        17,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal),
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
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: widget.data.image != ''
                                ? Image.network(
                                    widget.data.image,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    'images/wearehiring.gif',
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.data.position,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 180,
                                child: Text(
                                  widget.data.tencty,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const Icon(
                                Icons.location_on_outlined,
                                size: 17,
                              ),
                              Text(
                                  '${widget.data.khuvuchuyen}, ${widget.data.khuvuctinh}'),
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25))),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Text(
                                      'Mô tả công việc:',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      for (var i = 0;
                                          i < widget.data.motacv.length;
                                          i++)
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 5),
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
                                                      fontSize: 15,
                                                      color: Colors.black54),
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
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      for (var i = 0;
                                          i < widget.data.yeucaucv.length;
                                          i++)
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 5),
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
                                                      fontSize: 15,
                                                      color: Colors.black54),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20,
                                        left: 10,
                                        right: 10,
                                        bottom: 10),
                                    child: widget.userData.position ==
                                            'Thành viên'
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              InkWell(
                                                  onTap: () {
                                                    if (savejob == false) {
                                                      try {
                                                        value.updateSavejobs(
                                                            value.user.id,
                                                            widget.data.id);
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(const SnackBar(
                                                                behavior:
                                                                    SnackBarBehavior
                                                                        .floating,
                                                                content: Text(
                                                                    'Việc làm đã được lưu')));
                                                      } catch (e) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(SnackBar(
                                                                content: Text(e
                                                                    .toString())));
                                                      }
                                                    } else {
                                                      try {
                                                        value.removeSavejobs(
                                                            value.user.id,
                                                            widget.data.id);
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(const SnackBar(
                                                                behavior:
                                                                    SnackBarBehavior
                                                                        .floating,
                                                                content: Text(
                                                                    'Không lưu việc làm này nữa')));
                                                      } catch (e) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(SnackBar(
                                                                content: Text(e
                                                                    .toString())));
                                                      }
                                                    }
                                                    setState(() {
                                                      savejob = !savejob;
                                                    });
                                                  },
                                                  child: savejob
                                                      ? const Icon(
                                                          Icons
                                                              .favorite_rounded,
                                                          color: Colors.pink,
                                                        )
                                                      : const Icon(Icons
                                                          .favorite_border_outlined)),
                                              InkWell(
                                                onTap: () async {
                                                  setState(() {
                                                    loading = true;
                                                  });
                                                  SenderApplyJobDto sendData =
                                                      SenderApplyJobDto(
                                                          sendername: value
                                                              .user.fullname,
                                                          senderphone:
                                                              value.user.phone,
                                                          creatorid:
                                                              widget.data.user,
                                                          jobposition: widget
                                                              .data.position,
                                                          khuvuchuyen: widget
                                                              .data.khuvuchuyen,
                                                          khuvuctinh: widget
                                                              .data.khuvuctinh);
                                                  Map<String, dynamic>
                                                      sendDataJson =
                                                      SenderApplyJobDto.toJson(
                                                          sendData);
                                                  var url = Uri.parse(
                                                      'http://103.176.251.70:100/users/appliedjob');
                                                  var response =
                                                      await http.post(url,
                                                          body: sendDataJson);
                                                  if (response.statusCode ==
                                                      201) {
                                                    value.updateAppliedjobs(
                                                        value.user.id,
                                                        widget.data.id);
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(const SnackBar(
                                                            behavior:
                                                                SnackBarBehavior
                                                                    .floating,
                                                            content: Text(
                                                                'Ứng tuyển thành công! Nhà tuyển dụng sẽ sớm liên hệ lại cho bạn.')));
                                                    // Navigator.pop(context);
                                                    setState(() {
                                                      loading = false;
                                                      appliedjob = true;
                                                    });
                                                  } else {
                                                    setState(() {
                                                      loading = false;
                                                    });
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(const SnackBar(
                                                            behavior:
                                                                SnackBarBehavior
                                                                    .floating,
                                                            content: Text(
                                                                'Ứng tuyển thất bại, vui lòng kiểm tra lại kết nối mạng.')));
                                                  }
                                                },
                                                child: Container(
                                                  height: 45,
                                                  width: 150,
                                                  decoration: BoxDecoration(
                                                      color: appliedjob
                                                          ? Colors.blue
                                                          : Colors.green,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25)),
                                                  child: Center(
                                                      child: appliedjob
                                                          ? const Text(
                                                              'ĐÃ ỨNG TUYỂN',
                                                              style: TextStyle(
                                                                  fontSize: 17,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )
                                                          : const Text(
                                                              'ỨNG TUYỂN',
                                                              style: TextStyle(
                                                                  fontSize: 17,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )),
                                                ),
                                              )
                                            ],
                                          )
                                        : const Row(),
                                  )
                                ]),
                          ),
                        ),
                      ],
                    )),
                  ),
                  Visibility(
                    visible: loading,
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(color: Colors.black26),
                      child: const Center(
                          child: CircularProgressIndicator(
                        color: Colors.white,
                      )),
                    ),
                  ),
                ],
              ));
        },
      ),
    );
  }
}
