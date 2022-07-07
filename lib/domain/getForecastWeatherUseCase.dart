import 'package:weather/ForecastParams.dart';
import 'package:weather/dataState.dart';
import 'package:weather/useCase.dart';
import 'package:weather/Models/ForcastDaysModel.dart';
import 'package:weather/domain/ForecastWeatherRepository.dart';

class GetForecastWeatherUseCase extends UseCase<DataState<ForcastDaysModel>, ForecastParams> {

  final ForecastWeatherRepository _forecastWeatherRepository;

  GetForecastWeatherUseCase(this._forecastWeatherRepository);

  @override
  Future<DataState<ForcastDaysModel>> call(params) {
    return _forecastWeatherRepository.fetchForecastWeatherData(params);
  }
}