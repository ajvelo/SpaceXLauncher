import 'package:SpaceX_Launcher/model/launches.dart';
import 'package:equatable/equatable.dart';

abstract class LaunchesState extends Equatable {
  @override
  List<Object> get props => [];
}

class LaunchesInitState extends LaunchesState {}

class LaunchesLoading extends LaunchesState {}

class LaunchesLoaded extends LaunchesState {
  final List<Launch> launches;
  LaunchesLoaded({this.launches});
}

class LaunchesListError extends LaunchesState {
  final error;
  LaunchesListError({this.error});
}
