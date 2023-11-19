import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:myjobapp/Classes/jobs_class.dart';
import 'package:myjobapp/Pages/JobsPage/jobs_detail_screen.dart';
import 'package:myjobapp/Provider/Job_list_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class ShowJobOnMap extends StatefulWidget {
  const ShowJobOnMap({super.key});

  @override
  State<ShowJobOnMap> createState() => _ShowJobOnMapState();
}

class _ShowJobOnMapState extends State<ShowJobOnMap> {
  GoogleMapController? _controller;
  Set<Marker> markers = {};

  LatLng currentPosition = LatLng(0, 0);

  @override
  void initState() {
    super.initState();
  }

  void getCurrentLocation() async {
    getLocationPer();
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    final cameraPosition = CameraPosition(
        target: LatLng(position.latitude, position.longitude), zoom: 12);

    Marker userMarker = Marker(
      markerId: const MarkerId('My Location'),
      position: LatLng(position.latitude, position.longitude),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      infoWindow: const InfoWindow(
          title: 'Vị trí của tôi', snippet: 'Đang hiển thị bán kính 10km'),
    );
    _controller!.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    setState(() {
      markers.add(userMarker);
      currentPosition = LatLng(position.latitude, position.longitude);
    });
  }

  void getLocationPer() async {
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
                  'position': e.position,
                  'salary': e.salary,
                  'id': e.id,
                  'user': e.user,
                  'title': e.title,
                  'date': e.date,
                  'khuvuctinh': e.khuvuctinh,
                  'khuvuchuyen': e.khuvuchuyen,
                  'tencty': e.tencty,
                  'logocty': e.logocty,
                  'image': e.image,
                  'motacv': e.motacv,
                  'yeucaucv': e.yeucaucv,
                })
            .toList();
        for (var location in locations) {
          Marker marker = Marker(
              markerId: MarkerId(location.toString()),
              position: LatLng(location['latitude'], location['longitude']),
              infoWindow: InfoWindow(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => JobsDetailScr(
                                data: JobsClass.fromJson(location))));
                  },
                  title: location['position'],
                  snippet: '${location['salary']}  (Bấm để xem chi tiết)'));
          markers.add(marker);
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Job Map'),
          ),
          body: Stack(children: [
            GoogleMap(
              myLocationButtonEnabled: false,
              mapType: MapType.hybrid,
              markers: markers,
              circles: {
                Circle(
                    circleId: const CircleId('userCircle'),
                    center: currentPosition,
                    radius: 10000,
                    strokeWidth: 2,
                    fillColor: const Color(0xFF006491).withOpacity(0.2),
                    strokeColor: Colors.blue)
              },
              onMapCreated: (controller) => _controller = controller,
              initialCameraPosition: const CameraPosition(
                  target: LatLng(10.877617291961869, 106.66552950110372),
                  zoom: 10),
            ),
            Positioned(
                bottom: 100,
                right: 8,
                child: FloatingActionButton(
                  backgroundColor: Colors.blue.withOpacity(0.65),
                  tooltip: 'Vị trí của tôi',
                  mini: true,
                  onPressed: () {
                    getCurrentLocation();
                  },
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.white,
                  ),
                ))
          ]),
        );
      },
    ));
  }
}
