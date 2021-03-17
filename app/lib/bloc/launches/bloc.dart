import 'dart:io';
import 'package:SpaceX_Launcher/api/exceptions.dart';
import 'package:SpaceX_Launcher/api/services.dart';
import 'package:SpaceX_Launcher/bloc/launches/events.dart';
import 'package:SpaceX_Launcher/bloc/launches/states.dart';
import 'package:SpaceX_Launcher/model/launches.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LaunchesBloc extends Bloc<LaunchEvents, LaunchesState> {
  final LaunchRepo launchesRepo;
  List<Launch> launches;

  LaunchesBloc({this.launchesRepo}) : super(LaunchesInitState());

  @override
  Stream<LaunchesState> mapEventToState(LaunchEvents launchEvents) async* {
    switch (launchEvents.event) {
      case LaunchEvent.fetchLaunches:
        yield LaunchesLoading();
        try {
          launches = await launchesRepo.getLaunchList();
          yield LaunchesLoaded(launches: launches);
        } on SocketException {
          yield LaunchesListError(
            error: NoInternetException('No Internet'),
          );
        } on HttpException {
          yield LaunchesListError(
            error: NoServiceFoundException('No Service Found'),
          );
        } on FormatException {
          yield LaunchesListError(
            error: InvalidFormatException('Invalid Response format'),
          );
        } catch (e) {
          // Generic error
          yield LaunchesListError(
            error: UnknownException('Unknown Error'),
          );
        }
        break;
      case LaunchEvent.toggleFavorite:
        try {
          launches = await launchesRepo.toggleFavorite(launchEvents.value);
          yield LaunchesLoaded(launches: launches);
        } catch (e) {
          yield LaunchesListError(
            error: UnknownException('Unknown Error'),
          );
        }
        break;
    }
  }
}
