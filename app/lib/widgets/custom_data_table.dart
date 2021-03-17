import 'package:SpaceX_Launcher/bloc/launches/bloc.dart';
import 'package:SpaceX_Launcher/bloc/launches/events.dart';
import 'package:SpaceX_Launcher/model/launches.dart';
import 'package:SpaceX_Launcher/screens/current_launch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CustomDataTable extends StatefulWidget {
  const CustomDataTable(
      {Key key,
      @required this.context,
      @required this.launches,
      @required this.notifyParent})
      : super(key: key);

  final BuildContext context;
  final List<Launch> launches;
  final Function() notifyParent;

  @override
  _CustomDataTableState createState() => _CustomDataTableState();
}

class _CustomDataTableState extends State<CustomDataTable> {
  @override
  Widget build(BuildContext context) {
    // A DataTable allows us to apply a header to the respective columns
    return DataTable(showCheckboxColumn: false, columns: [
      DataColumn(
          label: Text(
        'Mission',
        style: TextStyle(fontSize: 20.0, color: Colors.white),
      )),
      DataColumn(
          label: Text('Date (UTC)',
              style: TextStyle(fontSize: 20.0, color: Colors.white))),
    ], rows: [
      for (var i = 0; i < widget.launches.length; i++)
        DataRow(
            onSelectChanged: (value) {
              Navigator.of(context)
                  .pushNamed(CurrentLaunch.routeName, arguments: {
                'timeToLaunch': widget.launches[i].dateUnix,
                'rocketName': widget.launches[i].name,
                'timeToLaunchFormatted':
                    DateFormat('dd/MM/yyyy').format(widget.launches[i].dateUtc)
              });
              return value;
            },
            cells: [
              DataCell(
                Row(
                  children: [
                    IconButton(
                      alignment: Alignment.centerLeft,
                      icon: Icon(
                        widget.launches[i].isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        BlocProvider.of<LaunchesBloc>(context).add(LaunchEvents(
                            event: LaunchEvent.toggleFavorite,
                            value: widget.launches[i]));
                        widget.notifyParent();
                      },
                    ),
                    Text(
                      widget.launches[i].name,
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  ],
                ),
              ),
              DataCell(
                Text(
                  "${DateFormat('dd/MM/yyyy').format(widget.launches[i].dateUtc)}",
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                ),
              ),
            ])
    ]);
  }
}
