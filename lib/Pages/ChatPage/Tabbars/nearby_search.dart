import 'package:app_settings/app_settings.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:cached_memory_image/cached_memory_image.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:myjobapp/Classes/component/list_users_info.dart';
import 'package:myjobapp/Pages/ChatPage/component/press_show_menu.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NearBySearchTabbar extends StatefulWidget {
  const NearBySearchTabbar({super.key, required this.usersData});
  final List<UserForSearch> usersData;

  @override
  State<NearBySearchTabbar> createState() => _NearBySearchTabbarState();
}

class _NearBySearchTabbarState extends State<NearBySearchTabbar> {
  List<UserForSearch> listUser = [];
  List<UserForSearch> filteredListUser = [];
  bool loading = false;

  @override
  void initState() {
    super.initState();
    getPositionAndFilter();
  }

  void getPositionAndFilter() async {
    if (mounted) {
      setState(() {
        loading = true;
      });
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? myUserId = prefs.getString('userid');

    var status = await Permission.location.request();
    if (status.isPermanentlyDenied) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        content: const Text(
          'Định vị đã tắt, bạn có muốn bật lại?',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        action: SnackBarAction(
          label: 'Đến Setting',
          onPressed: () {
            AppSettings.openAppSettings();
          },
        ),
      ));
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    String myLatitudeUpdate = position.latitude.toString();
    String myLongitudeUpdate = position.longitude.toString();

    var url = Uri.parse('https://qtechcom.io/users/$myUserId');
    var response = await http.patch(url,
        body: {"latitude": myLatitudeUpdate, "longitude": myLongitudeUpdate});

    if (response.statusCode == 200) {
      print('Update vị trí thành công');
    } else {
      throw Exception('Update thất bại, vui lòng kiểm tra lại kết nối!');
    }
    filteredListUser = widget.usersData
        .where((element) =>
            element.latitude != '' &&
            element.longitude != '' &&
            element.id != myUserId &&
            Geolocator.distanceBetween(
                    position.latitude,
                    position.longitude,
                    double.parse(element.latitude!),
                    double.parse(element.longitude!)) <
                45000)
        .toList();

    for (var user in filteredListUser) {
      double distance = Geolocator.distanceBetween(
          position.latitude,
          position.longitude,
          double.parse(user.latitude!),
          double.parse(user.longitude!));
      user.distance = distance;
    }
    filteredListUser.sort((a, b) => a.distance!.compareTo(b.distance!));

    if (mounted) {
      setState(() {
        filteredListUser = filteredListUser;
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
              child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: filteredListUser.length,
                  itemBuilder: (context, index) {
                    String distanceText;
                    if (filteredListUser[index].distance! < 1000) {
                      distanceText = 'Dưới 1 km';
                    } else {
                      int distanceInKm =
                          (filteredListUser[index].distance! ~/ 1000).toInt();
                      distanceText = 'Cách bạn khoảng $distanceInKm km';
                    }
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 30, bottom: 5, top: 5),
                      child: CustomPopupMenu(
                        pressType: PressType.singleClick,
                        menuBuilder: () {
                          return BuildLongPressMenu(
                            userData: filteredListUser[index],
                          );
                        },
                        barrierColor: Colors.transparent,
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              children: [
                                AvatarGlow(
                                  showTwoGlows: true,
                                  glowColor:
                                      const Color.fromARGB(255, 0, 206, 7),
                                  endRadius: 30,
                                  child: ClipOval(
                                    child: SizedBox(
                                      width: 45,
                                      height: 45,
                                      child: CachedMemoryImage(
                                        uniqueKey:
                                            filteredListUser[index].avatar,
                                        base64: filteredListUser[index].avatar,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        filteredListUser[index].fullname != ''
                                            ? filteredListUser[index].fullname
                                            : filteredListUser[index]
                                                .companyname,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        distanceText,
                                        style: const TextStyle(fontSize: 12),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      ),
                    );
                  },
                ),
              )
            ],
          )),
          Visibility(
            visible: loading,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(color: Colors.black12),
              child: const Center(
                  child: CircularProgressIndicator(
                color: Colors.white,
              )),
            ),
          ),
        ],
      ),
    );
  }
}
