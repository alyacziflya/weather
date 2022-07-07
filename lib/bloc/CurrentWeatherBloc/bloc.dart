import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather/dataState.dart';
import 'package:weather/domain/getCurrentWeatherUseCase.dart';
import 'package:weather/Models/CurrentCityModel.dart';

part 'event.dart';
part 'state.dart';

class CwBloc extends Bloc<CwEvent, CwState> {
  final GetCurrentWeatherUseCase _getCurrentWeatherUseCase;

  CwBloc(this._getCurrentWeatherUseCase) : super(CwLoading()) {

    on<LoadCwEvent>((event, emit) async {

      emit(CwLoading());

      DataState dataState = await _getCurrentWeatherUseCase(event.cityName);

      if(dataState is DataSuccess){
        emit(CwCompleted(dataState.data));
      }

      if(dataState is DataFailed){
        emit(CwError(dataState.error));
      }

    });
  }
}
