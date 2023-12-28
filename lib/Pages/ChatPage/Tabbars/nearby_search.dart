import 'package:app_settings/app_settings.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:myjobapp/Classes/component/list_users_info.dart';
import 'package:myjobapp/Pages/ChatPage/component/press_show_menu.dart';
import 'package:permission_handler/permission_handler.dart';

class NearBySearchTabbar extends StatefulWidget {
  const NearBySearchTabbar({super.key, required this.usersData});
  final List<UserForSearch> usersData;

  @override
  State<NearBySearchTabbar> createState() => _NearBySearchTabbarState();
}

class _NearBySearchTabbarState extends State<NearBySearchTabbar> {
  double userLongitude = 1;
  double userLatitude = 1;
  List<UserForSearch> listUser = [];

  @override
  void initState() {
    super.initState();
    getCurrentPosition();
  }

  void getCurrentPosition() async {
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
    if (mounted) {
      setState(() {
        userLatitude = position.latitude;
        userLongitude = position.longitude;
      });
    }

    print(userLatitude);
    print(userLongitude);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 30, bottom: 5, top: 5),
                  child: CustomPopupMenu(
                    pressType: PressType.singleClick,
                    menuBuilder: () {
                      return BuildLongPressMenu();
                    },
                    barrierColor: Colors.transparent,
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: const Row(
                          children: [
                            AvatarGlow(
                              showTwoGlows: true,
                              glowColor: Colors.blueAccent,
                              endRadius: 30,
                              child: CircleAvatar(
                                radius: 25,
                                backgroundImage: NetworkImage(
                                    'https://i.pinimg.com/originals/2b/0f/7a/2b0f7a9533237b7e9b49f62ba73b95dc.jpg'),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [Text('Nguyen Van A')],
                              ),
                            ),
                            Spacer(),
                            Text('Cách 5km')
                          ],
                        )),
                  ),
                );
              },
            ),
          )
        ],
      )),
    );
  }
}
