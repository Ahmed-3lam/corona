import 'dart:convert';

import 'package:corona/Models/all_countries_model.dart';
import 'package:corona/Network/dio_helper.dart';
import 'package:corona/Screens/details_screen.dart';
import 'package:corona/constant.dart';
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

final LatLng _center = const LatLng(26.8206, 30.8025);

void _onMapCreated(GoogleMapController controller) {
  mapController = controller;
}

class _MapScreenState extends State<MapScreen> {
  List<Circle> list =[] ;
   Set<Polyline>_polyline={};
  AllCountriesModel _model =AllCountriesModel();
  Future<void> getData()async{

    try {
      var response = await DioHelper.getData(
          url: coronaLocationsURL, query: {});
      print("here1");

      if (response.statusCode == 200) {
        print("here2");
        print(response.data.toString());
         _model =AllCountriesModel.fromJson(response.data) ;


        for (int i =0 ; i<_model.locations!.length-1;i++){
          list.add(
            Circle(
                circleId: CircleId("$i"),
                center: LatLng(double.parse(_model.locations![i].coordinates!.latitude.toString()) , double.parse(_model.locations![i].coordinates!.longitude.toString())),
                radius: 100000,
                fillColor: Colors.red,
                strokeColor: Colors.red
            ),
          );

          _polyline.add(Polyline(
            polylineId: PolylineId("$i"),
            visible: true,
            //latlng is List<LatLng>
            points:[LatLng(double.parse(_model.locations![i].coordinates!.longitude.toString()) , double.parse(_model.locations![i].coordinates!.latitude.toString())),LatLng(1.22, 2.55)]
    ,
            color: Colors.blue,
          ));
        }
        print(_model.locations![0].latest!.confirmed.toString() + "+++++++++++++++++++");

      } else {


      }
    } catch (err) {

      print(err.toString());
    }
  }
  @override
  void initState() {
    Future.delayed(Duration.zero);
    getData();
    super.initState();

  }

  @override
  void didChangeDependencies() async{
    await getData();

    super.didChangeDependencies();
  }





  void _onTap(LatLng lt){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailsScreen(lt: lt,)));
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: FutureBuilder(
        future: getData(),
        builder: (context,snapshot){
          Set<Circle> mCircle = Set.from(list);
          print(mCircle.toString());
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          return     GoogleMap(
            // polylines: _polyline,
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            onMapCreated: _onMapCreated,
            circles: mCircle,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,

            ),
            onTap: _onTap,
          );
        },
      )



    );
  }
}
