import 'package:SpaceX_Launcher/widgets/countdown_box.dart';
import 'package:share/share.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class CurrentLaunch extends StatefulWidget {
  static const routeName = '/current-launch';

  @override
  _CurrentLaunchState createState() => _CurrentLaunchState();
}

class _CurrentLaunchState extends State<CurrentLaunch> {
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;
    final timeToLaunch = routeArgs['timeToLaunch'] as int;
    final rocketName = routeArgs['rocketName'];
    final timeToLaunchFormatted = routeArgs['timeToLaunchFormatted'];
    return Scaffold(
      // Using a PreferredSize widget here to apply a gradient to the app bar
      appBar: PreferredSize(
        child: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 20.0, bottom: 20.0),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    rocketName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(Icons.share, color: Colors.white),
                    onPressed: () {
                      Share.share(
                          '$rocketName is launching on $timeToLaunchFormatted!');
                    },
                  ),
                ),
              ],
            ),
          ),
          decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [Colors.cyan[200], Colors.cyan[800]]),
          ),
        ),
        preferredSize: Size(MediaQuery.of(context).size.width, 80.0),
      ),
      body: Center(
        child: CountdownTimer(
          endTime: timeToLaunch * 1000,
          widgetBuilder: (context, time) {
            if (time == null) {
              return Center(
                child: Text(
                  'This rocket has already launched!',
                  style: TextStyle(color: Colors.red, fontSize: 24),
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              return Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.cyan[800], Colors.cyan[900]]),
                ),
                padding: const EdgeInsets.all(32.0),
                child: SingleChildScrollView(
                  child: Column(children: [
                    CountDownBox(
                      timeRemaining: time.days.toString(),
                      text: 'DAYS',
                    ),
                    CountDownBox(
                      timeRemaining: time.hours.toString(),
                      text: 'HOURS',
                    ),
                    CountDownBox(
                      timeRemaining: time.min.toString(),
                      text: 'MINUTES',
                    ),
                    CountDownBox(
                      timeRemaining: time.sec.toString(),
                      text: 'SECONDS',
                    ),
                  ]),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
