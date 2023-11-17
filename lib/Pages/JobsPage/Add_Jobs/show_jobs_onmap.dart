import 'dart:async';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:myjobapp/Provider/Job_list_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class ShowJobOnMap extends StatefulWidget {
  const ShowJobOnMap({super.key});

  @override
  State<ShowJobOnMap> createState() => _ShowJobOnMapState();
}

class _ShowJobOnMapState extends State<ShowJobOnMap> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  void getLocation() async {
    Map<Permission, PermissionStatus> status = await [
      Permission.location,
    ].request();
    if (status[Permission.location]!.isGranted) {
    } else if (status[Permission.location]!.isDenied) {
    } else if (status[Permission.location]!.isPermanentlyDenied) {
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
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<JobsProvider>(create: (context) {
      return JobsProvider();
    }, child: Consumer<JobsProvider>(
      builder: (context, value, child) {
        List<Map<String, dynamic>> locations = value.filterJobData
            .map((e) => {
                  'latitude': e.latitude,
                  'longitude': e.longitude,
                  'title': e.position,
                  'snippet': e.salary
                })
            .toList();
        Set<Marker> markers = {};
        for (var location in locations) {
          Marker marker = Marker(
              markerId: MarkerId(location.toString()),
              position: LatLng(location['latitude'], location['longitude']),
              infoWindow: InfoWindow(
                  title: location['title'], snippet: location['snippet']));
          markers.add(marker);
        }

        // LatLng currentPosition;
        // getCurrenPosition() async {
        //   currentPosition = await value.getCurrentLocation();
        // }

        // getCurrenPosition();

        return Scaffold(
          appBar: AppBar(
            title: const Text('Job Map'),
          ),
          body: GoogleMap(
            markers: markers,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            initialCameraPosition: const CameraPosition(
                target: LatLng(10.924918695447976, 106.5420558989949),
                zoom: 10),
          ),
        );
      },
    ));
  }
}
