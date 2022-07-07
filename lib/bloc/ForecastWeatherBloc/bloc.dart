import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather/ForecastParams.dart';
import 'package:weather/dataState.dart';
import 'package:weather/domain/getForecastWeatherUseCase.dart';
import 'package:weather/Models/ForcastDaysModel.dart';

part 'event.dart';
part 'state.dart';

class FwBloc extends Bloc<FwEvent, FwState> {
  final GetForecastWeatherUseCase _getForecastWeatherUseCase;

  FwBloc(this._getForecastWeatherUseCase) : super(FwLoading()) {

    on<LoadFwEvent>((event, emit) async {

      emit(FwLoading());

      DataState dataState = await _getForecastWeatherUseCase(event.forecastParams);

      if(dataState is DataSuccess){
        emit(FwCompleted(dataState.data));
      }

      if(dataState is DataFailed){
        emit(FwError(dataState.error));
      }

    });
  }
}