import 'package:SpaceX_Launcher/helpers/db_helper.dart';
import 'package:SpaceX_Launcher/model/launches.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

abstract class LaunchRepo {
  Future<List<Launch>> getLaunchList();
  Future<List<Launch>> toggleFavorite(Launch launch);
}

class LaunchServices implements LaunchRepo {
  static const _baseUrl = 'api.spacexdata.com';
  static const String GET_UPCOMING_LAUNCHES = '/v4/launches/upcoming';

  @override
  Future<List<Launch>> getLaunchList() async {
    // First we check the cache before calling the API
    var launches = await DBHelper.getLaunches();
    if (launches.isEmpty) {
      Uri uri = Uri.https(_baseUrl, GET_UPCOMING_LAUNCHES);
      Response response = await http.get(uri);
      List<Launch> launches = Launch.launchFromJson(response.body);
      launches.forEach((element) {
        DBHelper.addData(element);
      });
      return launches;
    }
    return launches;
  }

  @override
  Future<List<Launch>> toggleFavorite(launch) async {
    await DBHelper.toggleFavorite(launch);
    return getLaunchList();
  }
}
