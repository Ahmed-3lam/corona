import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:corona/Models/corona_model.dart';
import 'package:corona/Network/dio_helper.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

import '../../constant.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {

  DetailsCubit() : super(DetailsInitial());

  CoronaModel _coronaModel = CoronaModel();

  CoronaModel get coronaModel => _coronaModel;
  String countryCode = "Eg";

  List<String> countries = countriesCODE.keys.toList();

  var country="Egypt";


  void changeCountry(String? cd){
    countryCode = cd!;



emit(DetailsChangeCountryState());
    getCoronaData();

  }

  Future getCoronaData()async{
    emit(DetailsLoadingState());
    var response = await DioHelper.getData(url: coronaLocationsURL, query:{
      "country_code":countryCode
    });
    print("here1");
    if(response.statusCode == 200){
      print("here2");
      _coronaModel =CoronaModel.fromJson(response.data);

      print(_coronaModel.toString()+"+++++++++++++++++++");
      emit(DetailsSuccessState());
    }else{

      emit(DetailsErrorState(response.statusMessage));
      print(response.statusMessage);
    }
  }


   LatLng lt=const LatLng(45.521563, -122.677433);
   List<Placemark>? placeMarks;

  Future<List<Placemark>> getLocation() async {
emit(DetailsLoadingState());
    placeMarks = await placemarkFromCoordinates(
        lt.latitude, lt.longitude
    );
    print(placeMarks.toString());
    countryCode =placeMarks![0].isoCountryCode!;
    getCoronaData();
    return placeMarks!;

  }
}
