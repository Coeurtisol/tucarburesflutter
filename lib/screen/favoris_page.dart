// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tucarburesflutter/data/gas_station_data.dart';
import 'package:tucarburesflutter/fakedata/fakedata_gasstation.dart';
import 'package:tucarburesflutter/model/gas_station.dart';

class FavorisPage extends StatefulWidget {
  const FavorisPage({Key? key}) : super(key: key);

  @override
  State<FavorisPage> createState() => _FavorisPageState();
}

class _FavorisPageState extends State<FavorisPage> {
  final GasStation gasStation = GasStationsData().findGasStation("2");

  @override
  Widget build(BuildContext context) {
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
                ],
              ),
              SizedBox(width: 20),
              Column(children: [
                Text(gasStation.lane),
                Text(gasStation.zipCode),
                Text(gasStation.city),
                Icon(Icons.map)
              ])
            ],
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: <Widget>[
            for (var gasoline in gasStation.gasolineList)
              Row(
                children: [
                  // Text(gasoline.name + ' (' + gasoline.code + ') :'),
                  Text('${gasoline.name} :'),
                  SizedBox(width: 10),
                  Text(gasoline.price,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(" €")
                ],
              )
          ])
        ],
      ),
    );
  }
}
