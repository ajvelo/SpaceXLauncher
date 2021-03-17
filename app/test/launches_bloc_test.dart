import 'package:SpaceX_Launcher/api/services.dart';
import 'package:SpaceX_Launcher/bloc/launches/bloc.dart';
import 'package:SpaceX_Launcher/bloc/launches/events.dart';
import 'package:SpaceX_Launcher/bloc/launches/states.dart';
import 'package:SpaceX_Launcher/helpers/db_helper.dart';
import 'package:SpaceX_Launcher/model/launches.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'mock_launch_model.dart';

class MockLaunchRepo extends Mock implements LaunchRepo {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('LaunchBloc', () {
    LaunchRepo launchesRepo;
    LaunchesBloc launchesBloc;
    Launch mockLaunchModel;

    setUp(() async {
      launchesRepo = MockLaunchRepo();
      launchesBloc = LaunchesBloc(launchesRepo: launchesRepo);
      mockLaunchModel = MockLaunchModel.mockLaunchModel;
      await DBHelper.deleteDB();
    });

    tearDownAll(() async {
      await DBHelper.deleteDB();
    });

    group('FetchLaunches', () {
      blocTest(
        'emits [LaunchesLoading, LaunchesLoaded] when fetchLaunches is added and getLaunchList() succeeds',
        build: () {
          when(launchesRepo.getLaunchList()).thenAnswer(
            (_) => Future.value([mockLaunchModel]),
          );
          return launchesBloc;
        },
        act: (bloc) => bloc
            .add(LaunchEvents(event: LaunchEvent.fetchLaunches, value: null)),
        expect: [
          LaunchesLoading(),
          LaunchesLoaded(launches: [mockLaunchModel])
        ],
      );

      blocTest(
        'emits [LaunchesLoading, LaunchesListError] when fetchLaunches is added and getLaunchList() fails',
        build: () {
          when(launchesRepo.getLaunchList()).thenThrow("error");
          return launchesBloc;
        },
        act: (bloc) => bloc
            .add(LaunchEvents(event: LaunchEvent.fetchLaunches, value: null)),
        expect: [LaunchesLoading(), LaunchesListError()],
      );
    });

    group('Add Favorite', () {
      blocTest(
        'emits [LaunchesLoaded] when addFavorite is added and addFavorite() succeeds',
        build: () {
          when(launchesRepo.toggleFavorite(mockLaunchModel)).thenAnswer(
            (_) => Future.value([mockLaunchModel]),
          );
          return launchesBloc;
        },
        act: (bloc) => bloc
            .add(LaunchEvents(event: LaunchEvent.fetchLaunches, value: null)),
        expect: [
          LaunchesLoading(),
          LaunchesLoaded(launches: [mockLaunchModel])
        ],
      );
    });
  });
}
