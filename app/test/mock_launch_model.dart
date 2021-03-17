import 'package:SpaceX_Launcher/model/launches.dart';

class MockLaunchModel {
  static final mockLaunchModel = Launch(
      id: "123",
      isFavorite: false,
      dateUnix: 1619922313000,
      formattedDate: "02/05/2021",
      dateUtc: DateTime.fromMillisecondsSinceEpoch(1619922313000),
      name: "Starlink-22 (v1.0)");
  static final secondMockLaunchModel = Launch(
      id: "456",
      isFavorite: true,
      dateUnix: 1629922313000,
      formattedDate: "25/08/2021",
      dateUtc: DateTime.fromMillisecondsSinceEpoch(1629922313000),
      name: "Starlink-23 (v1.0)");

  static List<Launch> allLaunches() {
    return [mockLaunchModel, secondMockLaunchModel];
  }
}
