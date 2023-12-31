import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cached_memory_image/cached_image_base64_manager.dart';
import 'package:cached_memory_image/cached_memory_image.dart';
import 'package:cached_memory_image/provider/cached_memory_image_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myjobapp/Pages/PersonPage/Tabbar_List/posted_job_tabbar.dart';
import 'package:myjobapp/Provider/get_jobs_byid_provider.dart';
import 'package:myjobapp/Provider/login_get_update_user_provider.dart';
import 'package:myjobapp/bottombar_nav.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Tabbar_List/applied_tabbar.dart';
import 'Tabbar_List/save_tabbar.dart';
import 'change_password.dart';

class PersonPage extends StatefulWidget {
  const PersonPage({super.key});

  @override
  State<PersonPage> createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  XFile? image;
  XFile? result;
  String? base64Image;
  Uint8List? imageData;
  MemoryImage? memoryImage;
  CachedMemoryImageProvider? avatarImageProvider;

  @override
  void initState() {
    super.initState();
  }

  Future<XFile?> compressAndGetFile(File file, String targetPath) async {
    result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 60,
      rotate: 0,
    );
    if (mounted) {
      setState(() {
        result;
      });
    }

    return result;
  }

  void pickerAndConvertToBase64() async {
    final ImagePicker picker = ImagePicker();
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    final String targetPath =
        "$path/${DateTime.now().millisecondsSinceEpoch}.jpg";

    image = await picker.pickImage(source: ImageSource.gallery);
    if (mounted) {
      setState(() {
        image;
      });
    }

    if (image != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: image!.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 60,
        cropStyle: CropStyle.circle,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Chỉnh sửa ảnh',
              toolbarColor: Colors.black,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Chỉnh sửa ảnh',
          ),
        ],
      );
      await compressAndGetFile(File(croppedFile!.path), targetPath);
      if (result != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? myUserId = prefs.getString('userid');

        List<int> imageBytes = await result!.readAsBytes();
        base64Image = base64Encode(imageBytes);
        if (mounted) {
          setState(() {
            base64Image;
          });
        }

        await prefs.setString('useravatar', base64Image!);
        var url = Uri.parse('http://103.176.251.70:100/users/$myUserId');
        var response = await http.patch(url, body: {
          "avatar": base64Image,
        });

        if (response.statusCode == 200) {
          print('Update avatar thành công');

          final cachedImageManager = CachedImageBase64Manager.instance();
          await cachedImageManager.clearCache();

          if (mounted) {
            setState(() {
              CachedMemoryImage(
                placeholder: const CircularProgressIndicator(),
                fit: BoxFit.cover,
                uniqueKey: 'app://image/avatar',
                base64: base64Image,
              );
            });
          }
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text(
                    'Cập nhật thất bại, có thể do kích thước ảnh quá lớn')));
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetPostedJobsByID>(
      builder: (context, value, child) {
        return Consumer<GetUserProvider>(
          builder: (context, uservalue, child) {
            uservalue.getPreGetUser();
            return DefaultTabController(
              length: uservalue.user.position == 'Thành viên' ? 2 : 1,
              child: Scaffold(
                body: SafeArea(
                  child: CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        backgroundColor: Colors.transparent,
                        leading: IconButton(
                          onPressed: () {},
                          icon: Image.network(
                            'https://th.bing.com/th/id/R.cef7ade7807f8c0d60886922e91316c2?rik=vM3X8FUbkNUInw&pid=ImgRaw&r=0',
                            width: 30,
                            height: 30,
                          ),
                        ),
                        title: Center(
                          child: uservalue.user.position == 'Thành viên'
                              ? Text(
                                  uservalue.user.fullname,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                )
                              : Text(
                                  uservalue.user.companyname,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                        ),
                        actions: [
                          IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15))),
                                    context: context,
                                    builder: (context) {
                                      return StatefulBuilder(
                                        builder: (context, setState) {
                                          return Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 20, horizontal: 15),
                                            height: 110,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Column(children: [
                                              GestureDetector(
                                                child: const Row(
                                                  children: [
                                                    Icon(Icons.change_circle),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      'Đổi mật khẩu',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const ChangPasswordUser()));
                                                },
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              const Divider(
                                                indent: 5,
                                                thickness: 1,
                                                height: 3,
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              GestureDetector(
                                                child: const Row(
                                                  children: [
                                                    Icon(Icons
                                                        .settings_outlined),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      'Cài đặt và quyền riêng tư',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                onTap: () {
                                                  // DraggableScrollableSheet(
                                                  //   initialChildSize: 0.5,
                                                  //   minChildSize: 0.2,
                                                  //   maxChildSize: 0.8,
                                                  //   builder: (context,
                                                  //       scrollController) {
                                                  //     return Container(
                                                  //       color: Colors.green,
                                                  //     );
                                                  //   },
                                                  // );
                                                },
                                              ),
                                            ]),
                                          );
                                        },
                                      );
                                    });
                              },
                              icon: const Icon(
                                Icons.menu,
                                color: Colors.black,
                              ))
                        ],
                      ),
                      SliverList(
                          delegate: SliverChildListDelegate([
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                        onTap: () {
                                          pickerAndConvertToBase64();

                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const BottomBarNav(
                                                          pageindex: 4)));
                                        },
                                        child: ClipOval(
                                          child: Container(
                                              width: 100,
                                              height: 100,
                                              decoration: const BoxDecoration(
                                                  color: Colors.white12,
                                                  shape: BoxShape.circle),
                                              child: CachedMemoryImage(
                                                placeholder:
                                                    const CircularProgressIndicator(),
                                                fit: BoxFit.cover,
                                                uniqueKey: 'app://image/avatar',
                                                base64: uservalue.user.avatar,
                                              )),
                                        )),
                                  ),
                                ],
                              ),
                              Text(
                                '@_${uservalue.user.id}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      height: 40,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        border: Border.all(color: Colors.grey),
                                      ),
                                      child: const Center(
                                          child: Text('Sửa hồ sơ')),
                                    ),
                                  ),
                                  const SizedBox(width: 3),
                                  const Icon(Icons.qr_code_scanner),
                                ],
                              ),
                              uservalue.user.position == 'Thành viên'
                                  ? const TabBar(
                                      indicatorColor: Colors.green,
                                      labelColor: Colors.black,
                                      unselectedLabelColor: Colors.grey,
                                      tabs: [
                                          Tab(
                                              text: 'Đã ứng tuyển',
                                              icon: Icon(
                                                Icons.library_add_check,
                                                color: Colors.green,
                                              )),
                                          Tab(
                                              text: 'Đã lưu ',
                                              icon: Icon(
                                                Icons.favorite_sharp,
                                                color: Colors.pink,
                                              )),
                                        ])
                                  : TabBar(
                                      indicatorSize: TabBarIndicatorSize.label,
                                      indicatorColor: Colors.blue[780],
                                      labelColor: Colors.black,
                                      tabs: const [
                                          Tab(
                                            text: 'Bài tuyển dụng của tôi',
                                          ),
                                        ]),
                              SizedBox(
                                  height: 500,
                                  child: uservalue.user.position == 'Thành viên'
                                      ? TabBarView(children: [
                                          AppliedTabbar(
                                            userData: uservalue.user,
                                          ),
                                          SaveTabbar(
                                            userData: uservalue.user,
                                          ),
                                        ])
                                      : TabBarView(children: [
                                          PostedJobTabbar(
                                            userData: uservalue.user,
                                          ),
                                        ])),
                              const SizedBox(height: 100),
                            ],
                          ),
                        )
                      ])),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
