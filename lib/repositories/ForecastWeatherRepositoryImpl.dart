import 'package:dio/dio.dart';
import 'package:weather/ForecastParams.dart';
import 'package:weather/dataState.dart';
import 'package:weather/domain/ForecastWeatherRepository.dart';
import 'package:weather/Models/ForcastDaysModel.dart';
import 'package:weather/apiProvider.dart';

class ForecastWeatherRepositoryImpl extends ForecastWeatherRepository{

  final ApiProvider _apiProvider;

  ForecastWeatherRepositoryImpl(this._apiProvider);

  @override
  Future<DataState<ForcastDaysModel>> fetchForecastWeatherData(ForecastParams params) async {
    try{
      Response response = await _apiProvider.sendRequest7DaysForcast(params);

      if(response.statusCode == 200){
        ForcastDaysModel forecastDaysModel = ForcastDaysModel.fromJson(response.data);
        return DataSuccess(forecastDaysModel);
      }else{
        return DataFailed("try again...");
      }
    }catch(e){
      print(e.toString());
      return DataFailed("check your connection...");
    }
  }
}