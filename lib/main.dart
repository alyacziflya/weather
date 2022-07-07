import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/bloc/CurrentWeatherBloc/bloc.dart';
import 'package:weather/bloc/ForecastWeatherBloc/bloc.dart';
import 'package:weather/HomePage.dart';
import 'package:weather/locator.dart';

Future<void> main() async {
  await setup();
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => locator<CwBloc>()),
          BlocProvider(create: (_) => locator<FwBloc>()),
        ],
        child: Homepage(),
      )
  ));
}