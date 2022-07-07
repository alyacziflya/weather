part of 'bloc.dart';

@immutable
abstract class CwEvent {}

class LoadCwEvent extends CwEvent {
  final String cityName;
  LoadCwEvent(this.cityName);
}
