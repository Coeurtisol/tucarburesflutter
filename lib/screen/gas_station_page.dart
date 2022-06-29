// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, library_prefixes

import 'package:flutter/material.dart';
import 'package:tucarburesflutter/data/gas_station_data.dart';
import 'package:tucarburesflutter/model/gas_station.dart';
import 'package:tucarburesflutter/widget/gas_station_details.dart';

class GasStationPage extends StatefulWidget {
  const GasStationPage({Key? key, required this.uuid}) : super(key: key);

  final String uuid;

  @override
  State<GasStationPage> createState() => GasStationPageState();
}

class GasStationPageState extends State<GasStationPage> {
  var uuid;
  Future<GasStation> getGasStation() async {
    return await GasStationsData().$findGasStation(uuid);
  }

  @override
  Widget build(BuildContext context) {
    uuid = widget.uuid;
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text("Détails station"),
          ),
        ),
        body: FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData == true) {
                final gasStation = snapshot.data as GasStation;
                return GasStationDetails(gasStation: gasStation);
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Chargement des informations de la station'),
                      CircularProgressIndicator()
                    ],
                  ),
                );
              }
            },
            future: getGasStation()));
  }
}
