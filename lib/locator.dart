import 'package:get_it/get_it.dart';
import 'package:weather/repositories/CurrentWeatherRepositoryImpl.dart';
import 'package:weather/repositories/ForecastWeatherRepositoryImpl.dart';
import 'package:weather/repositories/SuggestCityRepositoryImpl.dart';
import 'package:weather/domain/getCurrentWeatherUseCase.dart';
import 'package:weather/domain/getForecastWeatherUseCase.dart';
import 'package:weather/bloc/CurrentWeatherBloc/bloc.dart';
import 'package:weather/bloc/ForecastWeatherBloc/bloc.dart';
import 'package:weather/apiProvider.dart';
import 'package:weather/domain/CurrentWeatherRepository.dart';
import 'package:weather/domain/ForecastWeatherRepository.dart';

GetIt locator = GetIt.instance;

Future<void> setup() async {
  locator.registerSingleton<ApiProvider>(ApiProvider());

  // inject Repositories
  locator.registerSingleton<CurrentWeatherRepository>(CurrentWeatherRepositoryImpl(locator()));
  locator.registerSingleton<ForecastWeatherRepository>(ForecastWeatherRepositoryImpl(locator()));
  locator.registerSingleton<SuggestCityRepositoryImpl>(SuggestCityRepositoryImpl(locator()));

  // inject UseCases
  locator.registerSingleton<GetCurrentWeatherUseCase>(GetCurrentWeatherUseCase(locator()));
  locator.registerSingleton<GetForecastWeatherUseCase>(GetForecastWeatherUseCase(locator()));

  locator.registerSingleton<CwBloc>(CwBloc(locator()));
  locator.registerSingleton<FwBloc>(FwBloc(locator()));
}