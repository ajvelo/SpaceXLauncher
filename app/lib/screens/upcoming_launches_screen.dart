import 'package:SpaceX_Launcher/bloc/launches/bloc.dart';
import 'package:SpaceX_Launcher/bloc/launches/events.dart';
import 'package:SpaceX_Launcher/bloc/launches/states.dart';
import 'package:SpaceX_Launcher/model/launches.dart';
import 'package:SpaceX_Launcher/widgets/custom_data_table.dart';
import 'package:SpaceX_Launcher/widgets/error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpcomingLaunchesScreen extends StatefulWidget {
  @override
  _UpcomingLaunchesScreenState createState() => _UpcomingLaunchesScreenState();
}

class _UpcomingLaunchesScreenState extends State<UpcomingLaunchesScreen> {
  bool viewFavoritesOnly = false;
  @override
  void initState() {
    super.initState();
    _loadLaunches();
  }

  _loadLaunches() async {
    context
        .read<LaunchesBloc>()
        .add(LaunchEvents(event: LaunchEvent.fetchLaunches, value: null));
  }

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
                    alignment: Alignment.centerLeft,
                    icon: Icon(
                        (viewFavoritesOnly
                            ? Icons.favorite
                            : Icons.favorite_border),
                        color: Colors.white),
                    onPressed: () {
                      setState(() {
                        viewFavoritesOnly = !viewFavoritesOnly;
                      });
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Upcoming Launches',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.purple[200], Colors.purple[800]]),
          ),
        ),
        preferredSize: Size(MediaQuery.of(context).size.width, 80.0),
      ),
      body: Container(
        child: _body(),
      ),
    );
  }

  _body() {
    return Column(
      children: [
        BlocBuilder<LaunchesBloc, LaunchesState>(
            builder: (BuildContext context, LaunchesState state) {
          if (state is LaunchesListError) {
            final error = state.error;
            String message = '${error.message}\nTap to Retry.';
            return ErrorTxt(
              message: message,
              onTap: _loadLaunches,
            );
          }
          if (state is LaunchesLoaded) {
            List<Launch> launches =
                BlocProvider.of<LaunchesBloc>(context).launches;
            launches.sort((a, b) => a.dateUtc.compareTo(b.dateUtc));
            return _list(launches, viewFavoritesOnly, context);
          }
          return Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }),
      ],
    );
  }

  Widget _list(
      List<Launch> launches, bool viewFavoritesOnly, BuildContext context) {
    if (viewFavoritesOnly)
      launches =
          launches.where((element) => element.isFavorite == true).toList();
    return Expanded(
      child: Container(
        child: launches.isEmpty && viewFavoritesOnly
            ? Container(
                constraints:
                    BoxConstraints(minWidth: MediaQuery.of(context).size.width),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.purple[700], Colors.purple[900]]),
                ),
                child: Center(
                  child: Text(
                    'You have no favorites added yet.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22.0, color: Colors.white),
                  ),
                ),
              )
            : ListView(
                physics: ClampingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: [
                    Container(
                      constraints: BoxConstraints(
                          minWidth: MediaQuery.of(context).size.width),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.purple[700], Colors.purple[900]]),
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: CustomDataTable(
                            context: context,
                            launches: launches,
                            notifyParent: refresh),
                      ),
                    ),
                  ]),
      ),
    );
  }
}
