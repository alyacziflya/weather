import 'package:weather/dataState.dart';
import 'package:weather/useCase.dart';
import 'package:weather/domain/CurrentWeatherRepository.dart';
import 'package:weather/Models/CurrentCityModel.dart';

class GetCurrentWeatherUseCase extends UseCase<DataState<CurrentCityModel>, String> {

  final CurrentWeatherRepository _currentWeatherRepository;

  GetCurrentWeatherUseCase(this._currentWeatherRepository);

  @override
  Future<DataState<CurrentCityModel>> call(String params) {
    return _currentWeatherRepository.fetchCurrentWeatherData(params);
  }

}