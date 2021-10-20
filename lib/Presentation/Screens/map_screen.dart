import 'package:corona/Presentation/cubit/map/map_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'details_screen.dart';

class MapScreen extends StatelessWidget {
  MapScreen({Key? key}) : super(key: key);

  late GoogleMapController mapController;

  final LatLng _center = const LatLng(26.8206, 30.8025);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    void _onTap(LatLng lt) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DetailsScreen(
                lt: lt,
              )));
    }

    return Scaffold(
        body: BlocProvider(
            create: (BuildContext context) => MapCubit()..getData(),
            child: BlocConsumer<MapCubit, MapState>(
                listener: (context, state) {},
                builder: (context, state) {
                  final cubit = BlocProvider.of<MapCubit>(context);
                  if (state == MapLoadingState()) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return GoogleMap(
                    // polylines: _polyline,
                    mapType: MapType.normal,
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    onMapCreated: _onMapCreated,
                    circles: cubit.mCircle,
                    initialCameraPosition: CameraPosition(
                      target: _center,
                      zoom: 0,
                    ),
                    onTap: _onTap,
                  );
                })));
  }
}
