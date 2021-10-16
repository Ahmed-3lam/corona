
import 'package:corona/Network/dio_helper.dart';
import 'package:corona/cubit/details/details_cubit.dart';
import 'package:corona/widgets/counter.dart';
import 'package:corona/widgets/my_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'Screens/details_screen.dart';
import 'constant.dart';

void main() async{
  await DioHelper.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
        BlocProvider(create: (context) => DetailsCubit()..getCoronaData()),
    ],
    child:

      MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid 19',
      theme: ThemeData(
          scaffoldBackgroundColor: kBackgroundColor,
          fontFamily: "Poppins",
          textTheme: TextTheme(
            bodyText1: TextStyle(color: kBodyTextColor),
          )),
      home: DetailsScreen(),
    )
    );
  }
}


