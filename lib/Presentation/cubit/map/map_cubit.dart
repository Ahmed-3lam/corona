import 'package:bloc/bloc.dart';
import 'package:corona/Data/Models/all_countries_model.dart';
import 'package:corona/Data/Network/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

import '../../../constant.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(MapInitial());
  List<Circle> list = [];

  Set<Polyline> _polyline = {};
  AllCountriesModel _model = AllCountriesModel();

  Set<Polyline> get polyline => _polyline;

  AllCountriesModel get model => _model;
  Set<Circle> mCircle = {};

  Future<void> getData() async {
    emit(MapLoadingState());
    try {
      var response =
          await DioHelper.getData(url: coronaLocationsURL, query: {});
      print("here1");

      if (response.statusCode == 200) {
        print("here2");
        print(response.data.toString());
        _model = AllCountriesModel.fromJson(response.data);

         for (int i = 0; i < _model.locations!.length - 1; i++) {
          list.add(
            Circle(
                circleId: CircleId("$i"),
                center: LatLng(
                    double.parse(
                        _model.locations![i].coordinates!.latitude.toString()),
                    double.parse(_model.locations![i].coordinates!.longitude
                        .toString())),
                radius: 200000,
                fillColor: Colors.red.withOpacity(
                    1-( _model.locations![i].latest!.confirmed! /
                        _model.latest!.confirmed!)),
                strokeColor: Colors.red.withOpacity(
                    1-( _model.locations![i].latest!.confirmed! /
                        _model.latest!.confirmed!))),
          );

           mCircle = Set.from(list);
        }

        emit(MapSuccessState());
      } else {
        emit(MapErrorState());
      }
    } catch (err) {
      emit(MapErrorState());
      print(err.toString());
    }
  }
}
