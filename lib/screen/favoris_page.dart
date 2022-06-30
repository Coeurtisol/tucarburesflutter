// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors,, library_prefixes

import 'package:flutter/material.dart';
import 'package:tucarburesflutter/data/gas_station_data.dart';
import 'package:tucarburesflutter/model/gas_station.dart';
import 'package:tucarburesflutter/widget/gas_station_details.dart';

class FavorisPage extends StatefulWidget {
  const FavorisPage({Key? key}) : super(key: key);

  @override
  State<FavorisPage> createState() => _FavorisPageState();
}

class _FavorisPageState extends State<FavorisPage> {
  Future<GasStation> getGasStation() async {
    return await GasStationsData().$findGasStation("62bbfab18ba8ee41cdcca422");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
                  Text('Chargement des informations de ma station'),
                  CircularProgressIndicator()
                ],
              ),
            );
          }
        },
        future: getGasStation());
  }
}
