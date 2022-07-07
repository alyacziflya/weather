import 'package:weather/ForecastParams.dart';
import 'package:weather/dataState.dart';
import 'package:weather/Models/ForcastDaysModel.dart';

abstract class ForecastWeatherRepository{
  Future<DataState<ForcastDaysModel>> fetchForecastWeatherData(ForecastParams params);
}