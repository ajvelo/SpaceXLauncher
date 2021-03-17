import 'package:SpaceX_Launcher/api/services.dart';
import 'package:SpaceX_Launcher/bloc/launches/bloc.dart';
import 'package:SpaceX_Launcher/screens/current_launch.dart';
import 'package:SpaceX_Launcher/screens/upcoming_launches_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Space X Launcher',
        debugShowCheckedModeBanner: false,
        theme: Theme.of(context).copyWith(dividerColor: Colors.white),
        home: BlocProvider(
          create: (context) => LaunchesBloc(launchesRepo: LaunchServices()),
          child: UpcomingLaunchesScreen(),
        ),
        routes: {
          CurrentLaunch.routeName: (ctx) => CurrentLaunch(),
        });
  }
}
