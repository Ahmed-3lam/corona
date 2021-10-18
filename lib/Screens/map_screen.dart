import 'package:corona/Screens/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}
late GoogleMapController mapController;

final LatLng _center = const LatLng(45.521563, -122.677433);

void _onMapCreated(GoogleMapController controller) {
  mapController = controller;
}

class _MapScreenState extends State<MapScreen> {
  void _onTap(LatLng lt){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailsScreen(lt: lt,)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,

        ),
        onTap: _onTap,
      ),

    );
  }
}
