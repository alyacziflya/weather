import 'package:dio/dio.dart';
import 'package:weather/dataState.dart';
import 'package:weather/domain/CurrentWeatherRepository.dart';
import 'package:weather/Models/CurrentCityModel.dart';
import 'package:weather/apiProvider.dart';

class CurrentWeatherRepositoryImpl extends CurrentWeatherRepository{
  final ApiProvider _apiProvider;

  CurrentWeatherRepositoryImpl(this._apiProvider);

  @override
  Future<DataState<CurrentCityModel>> fetchCurrentWeatherData(cityName) async {
    try{
      Response response = await _apiProvider.sendRequestCurrentWeather(cityName);

      if(response.statusCode == 200){
        CurrentCityModel currentCityDataModel = CurrentCityModel.fromJson(response.data);
        return DataSuccess(currentCityDataModel);
      }else{
        return DataFailed("try again...");
      }
    }catch(e){
      print(e.toString());
      return DataFailed("check your connection...");
    }
  }
}