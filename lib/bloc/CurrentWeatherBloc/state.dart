part of 'bloc.dart';

@immutable
abstract class CwState {}

class CwLoading extends CwState{}

class CwCompleted extends CwState{
  final CurrentCityModel currentCityModel;
  CwCompleted(this.currentCityModel);
}

class CwError extends CwState{
  final String? message;
  CwError(this.message);
}