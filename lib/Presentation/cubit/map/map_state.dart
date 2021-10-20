part of 'map_cubit.dart';

@immutable
abstract class MapState {}

class MapInitial extends MapState {}
class MapLoadingState extends MapState {}
class MapSuccessState extends MapState {}
class MapErrorState extends MapState {}
