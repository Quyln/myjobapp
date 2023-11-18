import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _controller;
  LatLng? _seclectedLocation;
  LatLng currentPosition = LatLng(0, 0);

  void _onMapTapped(LatLng location) {
    setState(() {
      _seclectedLocation = location;
    });
  }

  void getCurrentLocation() async {
    getLocationPer();
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    final cameraPosition = CameraPosition(
        target: LatLng(position.latitude, position.longitude), zoom: 12);

    _controller!.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    setState(() {
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
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        onMapCreated: (controller) => _controller = controller,
        onTap: _onMapTapped,
        initialCameraPosition: const CameraPosition(
          target: LatLng(11.081854605765315, 106.64105098559263),
          zoom: 10,
        ),
        markers: _seclectedLocation != null
            ? Set<Marker>.from([
                Marker(
                  markerId: MarkerId('selected_location'),
                  position: _seclectedLocation!,
                )
              ])
            : Set<Marker>(),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.done),
        label: const Text('XÁC NHẬN'),
        onPressed: () async {
          if (_seclectedLocation != null) {
            double latitude = _seclectedLocation!.latitude;
            double longitude = _seclectedLocation!.longitude;

            SharedPreferences pref = await SharedPreferences.getInstance();
            await pref.setString('creJobLat', latitude.toString());
            await pref.setString('creJobLong', longitude.toString());
            Navigator.pop(context, latitude.toString());
          }
        },
      ),
    );
  }
}
