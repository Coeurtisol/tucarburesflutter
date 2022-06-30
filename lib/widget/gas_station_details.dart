// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors,, library_prefixes

import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:tucarburesflutter/model/gas_station.dart';
import 'package:tucarburesflutter/util/date_util.dart';

class GasStationDetails extends StatefulWidget {
  const GasStationDetails({Key? key, required this.gasStation})
      : super(key: key);

  final GasStation gasStation;

  @override
  State<GasStationDetails> createState() => _GasStationDetailsState();
}

class _GasStationDetailsState extends State<GasStationDetails> {
  @override
  Widget build(BuildContext context) {
    final gasStation = widget.gasStation;
    return Center(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(gasStation.brand),
                  Text(gasStation.name),
                  Text("(à X km)"),
                ],
              ),
              SizedBox(width: 20),
              Column(children: [
                Text(gasStation.lane),
                Text(gasStation.zipCode),
                Text(gasStation.city),
                ElevatedButton.icon(
                    onPressed: () => MapsLauncher.launchCoordinates(
                        gasStation.latitude, gasStation.longitude),
                    icon: Icon(Icons.location_on),
                    label: Text("Ouvrir avec Maps"))
              ])
            ],
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: <Widget>[
            for (var statement in gasStation.statementList)
              Row(
                children: [
                  Text(statement.gasoline.name),
                  SizedBox(width: 5),
                  Text("(${statement.gasoline.code}) :"),
                  SizedBox(width: 5),
                  Text(statement.price.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(" €"),
                  SizedBox(width: 10),
                  //
                  Text(DateUtil().convertDate(statement.localDate)),
                ],
              )
          ])
        ],
      ),
    );
  }
}
