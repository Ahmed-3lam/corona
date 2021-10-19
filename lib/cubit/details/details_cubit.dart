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

  ///Model Data
  CoronaModel _coronaModel = CoronaModel();

  CoronaModel get coronaModel => _coronaModel;

  ///Country Variables
  String countryCode = "Eg";
  List<String> countries = countriesCODE.keys.toList();
  var country = "Egypt";

  /// DropMenu Change Method
  void changeCountry(String? cd) async {
    countryCode = cd!;

    await getCountryCovidData();
  }

  ///Initial Method from Map
  Future getCoronaDataFromMap(LatLng lt) async {
    emit(DetailsLoadingState());

    List<Placemark> placeMarks =
        await placemarkFromCoordinates(lt.latitude, lt.longitude);
    print(placeMarks.toString());
    countryCode = placeMarks[0].isoCountryCode!;
    country = placeMarks[0].country!;

    await getCountryCovidData();
  }


  /// General Method to get country covid data
  getCountryCovidData() async {
    emit(DetailsLoadingState());

    try {
      var response = await DioHelper.getData(
          url: coronaLocationsURL, query: {"country_code": countryCode});
      // print("here1");

      if (response.statusCode == 200) {
        // print("here2");
        _coronaModel = CoronaModel.fromJson(response.data);

        print(_coronaModel.toString() + "+++++++++++++++++++");
        emit(DetailsSuccessState());
      } else {
        emit(DetailsErrorState(response.statusMessage));
        print(response.statusMessage);
      }
    } catch (err) {
      emit(DetailsErrorState("No Data"));
      print(err.toString());
    }
  }
}
