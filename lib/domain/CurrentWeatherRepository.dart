import 'package:weather/dataState.dart';
import 'package:weather/Models/CurrentCityModel.dart';

abstract class CurrentWeatherRepository{
  Future<DataState<CurrentCityModel>> fetchCurrentWeatherData(String cityName);
}