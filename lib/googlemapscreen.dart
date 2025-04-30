import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class OpenStreetMapScreen extends StatefulWidget {
  const OpenStreetMapScreen({super.key});

  @override
  State<OpenStreetMapScreen> createState() => _OpenStreetMapScreenState();
}

class _OpenStreetMapScreenState extends State<OpenStreetMapScreen> {
  LatLng? _userLocation;

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _userLocation = LatLng(position.latitude, position.longitude);
    });
  }

  // final List<LatLng> polylinePoints = [
  //   LatLng(28.6139, 77.2090),  // Delhi
  //   LatLng(28.7041, 77.1025),  // Delhi Point 2
  //   LatLng(28.5355, 77.3910),  // Noida
  //   LatLng(28.4595, 77.0266),  // Gurugram
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("OpenStreetMap")),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(37.7749, -122.4194),
            initialZoom: 12.0,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          if (_userLocation != null)
            MarkerLayer(
              markers: [
                Marker(
                  point: _userLocation!,
                  width: 40,
                  height: 40,
                  child: Icon(Icons.location_pin, color: Colors.red, size: 40),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
