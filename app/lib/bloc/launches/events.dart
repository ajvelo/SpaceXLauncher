import 'package:SpaceX_Launcher/model/launches.dart';

enum LaunchEvent { fetchLaunches, toggleFavorite }

class LaunchEvents {
  final LaunchEvent event;
  final Launch value;

  const LaunchEvents({this.event, this.value});
}
