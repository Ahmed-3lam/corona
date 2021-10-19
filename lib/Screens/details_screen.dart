import 'package:corona/cubit/details/details_cubit.dart';
import 'package:corona/widgets/counter.dart';
import 'package:corona/widgets/my_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../constant.dart';

class DetailsScreen extends StatelessWidget {
  final LatLng? lt;
  final double offset = 0;
  TextEditingController _controller = TextEditingController();

  DetailsScreen({Key? key, this.lt}) : super(key: key);


  @override
  Widget build(BuildContext context) {



    return Scaffold(
        body: BlocProvider(
            create: (BuildContext context) => DetailsCubit()..getCoronaDataFromMap(lt!),
            child: BlocConsumer<DetailsCubit, DetailsState>(
                listener: (context, state) {},
                builder: (context, state) {
                  final cubit = BlocProvider.of<DetailsCubit>(context );

                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        MyHeader(
                          image: "assets/icons/Drcorona.svg",
                          textTop: "All you need",
                          textBottom: "is stay at home.",
                          offset: offset,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          height: 60,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              color: Color(0xFFE5E5E5),
                            ),
                          ),
                          child: Row(
                            children: <Widget>[
                              SvgPicture.asset(
                                  "assets/icons/maps-and-flags.svg"),
                              SizedBox(width: 20),
                              Expanded(
                                  child: BlocBuilder<DetailsCubit,
                                      DetailsState>(builder: (context, state) {
                                    // var country = cubit.placeMarks![0].country ??"Egypt";
                                    // if(state==DetailsLoadingFromMapState()){
                                    //   return Center(child: CircularProgressIndicator(),);
                                    // }


                                    return DropdownButton(
                                      isExpanded: true,
                                      underline: SizedBox(),
                                      icon: SvgPicture.asset(
                                          "assets/icons/dropdown.svg"),
                                      value: cubit.country,
                                      items: cubit.countries
                                          .map<DropdownMenuItem<String>>((
                                          String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        cubit.country = value as String;
                                        var code = countriesCODE[value];
                                        cubit.changeCountry(code);
                                      },
                                    );
                                  })

                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "Latest Update\n",
                                          style: kTitleTextstyle,
                                        ),
                                        TextSpan(
                                          text: "Newest update ${DateTime.now()
                                              .toString()
                                              .substring(0, 10)}",
                                          style: TextStyle(
                                            color: kTextLightColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "See details",
                                    style: TextStyle(
                                      color: kPrimaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Container(
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0, 4),
                                        blurRadius: 30,
                                        color: kShadowColor,
                                      ),
                                    ],
                                  ),
                                  child: BlocBuilder<DetailsCubit,
                                      DetailsState>(
                                      builder: (context, state) {
                                        if (state is DetailsLoadingState) {
                                          return
                                            Center(
                                                child: CircularProgressIndicator());
                                        } else if (state is DetailsErrorState) {
                                          return Container(
                                            child: Text("No Data Available , Please Choose Another Place",style: TextStyle(
                                              color: Colors.red
                                            ),),);
                                        } else {
                                          return Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceBetween,
                                            children: <Widget>[
                                              Counter(
                                                color: kInfectedColor,
                                                number: cubit.coronaModel
                                                    .latest!.confirmed,
                                                title: "Infected",
                                              ),
                                              Counter(
                                                color: kDeathColor,
                                                number: cubit.coronaModel
                                                    .latest!.deaths,
                                                title: "Deaths",
                                              ),
                                              Counter(
                                                color: kRecovercolor,
                                                number: cubit.coronaModel
                                                    .latest!.recovered,
                                                title: "Recovered",
                                              ),
                                            ],
                                          );
                                        }
                                      })),

                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
            )
        )
    );
  }
}
