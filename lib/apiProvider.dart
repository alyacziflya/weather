import 'package:dio/dio.dart';
import 'package:weather/ForecastParams.dart';

class ApiProvider{

  Dio _dio = Dio();

  Future<dynamic> sendRequestCurrentWeather(cityName) async {
    var apiKey = 'ed888b1401a267d20dfc7364409478de';

    var response = await _dio.get(
        "https://api.openweathermap.org" + "/data/2.5/weather",
        queryParameters: {'q': cityName, 'appid': apiKey, 'units': 'metric'});
    return response;
  }

  Future<dynamic> sendRequest7DaysForcast(ForecastParams params) async {
    var apiKey = 'ed888b1401a267d20dfc7364409478de';

    var response = await _dio.get(
        "https://api.openweathermap.org" + "/data/2.5/onecall",
        queryParameters: {
          'lat': params.lat,
          'lon': params.lon,
          'exclude': 'minutely,hourly',
          'appid': apiKey,
          'units': 'metric'
        });

    return response;
  }

  Future<dynamic> sendRequestCitySuggestion(String prefix) async {

    var response = await _dio.get(
        "http://geodb-free-service.wirefreethought.com/v1/geo/cities",
        queryParameters: {'limit': 7, 'offset': 0, 'namePrefix': prefix});
    return response;
  }
}