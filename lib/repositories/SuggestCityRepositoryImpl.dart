import 'package:dio/dio.dart';
import 'package:weather/Models/SuggestCityModel.dart';
import 'package:weather/apiProvider.dart';

class SuggestCityRepositoryImpl{
  final ApiProvider _apiProvider;

  SuggestCityRepositoryImpl(this._apiProvider);

  Future<List<Data>> fetchSuggestData(cityName) async {

    Response response = await _apiProvider.sendRequestCitySuggestion(cityName);

    SuggestCityModel suggestCityModel = SuggestCityModel.fromJson(response.data);

    return suggestCityModel.data!;
  }
}