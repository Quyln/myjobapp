import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;
  LatLng? _seclectedLocation;

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _onMapTapped(LatLng location) {
    setState(() {
      _seclectedLocation = location;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chọn vị trí làm việc')),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        onTap: _onMapTapped,
        initialCameraPosition: CameraPosition(
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_seclectedLocation != null) {
            double latitude = _seclectedLocation!.latitude;
            double longitude = _seclectedLocation!.longitude;

            SharedPreferences pref = await SharedPreferences.getInstance();
            await pref.setString('creJobLat', latitude.toString());
            await pref.setString('creJobLong', longitude.toString());

            print('${latitude} , ${longitude}');
            Navigator.pop(context);
          }
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
