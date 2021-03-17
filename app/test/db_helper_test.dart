import 'package:SpaceX_Launcher/helpers/db_helper.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mock_launch_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(() async {
    await DBHelper.deleteDB();
  });

  tearDown(() async {
    await DBHelper.deleteDB();
  });

  group('DBHelper', () {
    test('Add data', () async {
      // at the beginning database is empty
      expect(
          (await DBHelper.getLaunches().then((value) => value.isEmpty)), true);

      // insert one empty item
      DBHelper.addData(MockLaunchModel.mockLaunchModel);
      expect((await DBHelper.getLaunches().then((value) => value.length)), 1);

      // insert more empty items
      DBHelper.addData(MockLaunchModel.mockLaunchModel);
      DBHelper.addData(MockLaunchModel.mockLaunchModel);
      DBHelper.addData(MockLaunchModel.mockLaunchModel);
      expect((await DBHelper.getLaunches().then((value) => value.length)), 1);

      // insert a valid item
      DBHelper.addData(MockLaunchModel.secondMockLaunchModel);
      expect((await DBHelper.getLaunches().then((value) => value.length)), 2);
      // insert few times more the same item
      DBHelper.addData(MockLaunchModel.secondMockLaunchModel);
      DBHelper.addData(MockLaunchModel.secondMockLaunchModel);
      DBHelper.addData(MockLaunchModel.secondMockLaunchModel);
      expect((await DBHelper.getLaunches().then((value) => value.length)), 2);
    });

    test('Add favorite', () async {
      DBHelper.addData(MockLaunchModel.mockLaunchModel);
      expect((await DBHelper.getLaunches().then((value) => value.length)), 1);
      expect(
          (await DBHelper.getLaunches().then((value) => value
              .firstWhere(
                  (element) => element.id == MockLaunchModel.mockLaunchModel.id)
              .isFavorite)),
          false);
      DBHelper.toggleFavorite(MockLaunchModel.mockLaunchModel);
      expect(
          (await DBHelper.getLaunches().then((value) => value
              .firstWhere(
                  (element) => element.id == MockLaunchModel.mockLaunchModel.id)
              .isFavorite)),
          true);
    });

    test('Un-favorite', () async {
      DBHelper.addData(MockLaunchModel.secondMockLaunchModel);
      expect(
          (await DBHelper.getLaunches().then((value) => value
              .firstWhere((element) =>
                  element.id == MockLaunchModel.secondMockLaunchModel.id)
              .isFavorite)),
          true);
      await DBHelper.toggleFavorite(MockLaunchModel.secondMockLaunchModel);
      expect(
          (await DBHelper.getLaunches().then((value) => value
              .firstWhere((element) =>
                  element.id == MockLaunchModel.secondMockLaunchModel.id)
              .isFavorite)),
          false);
    });
  });
}
