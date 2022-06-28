// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tucarburesflutter/data/gas_station_data.dart';
import 'package:tucarburesflutter/fakedata/fakedata_gasstation.dart';
import 'package:tucarburesflutter/model/gas_station.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'dart:math' as Math;
import 'package:geolocator/geolocator.dart';

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
                  Text("(à X km)"),
                  // Text("(à ${gasStation.distance} km)"),
                ],
              ),
              SizedBox(width: 20),
              Column(children: [
                Text(gasStation.lane),
                Text(gasStation.zipCode),
                Text(gasStation.city),
                ElevatedButton.icon(
                    onPressed: () => MapsLauncher.launchCoordinates(
                        double.parse(gasStation.latitude),
                        double.parse(gasStation.longitude)),
                    icon: Icon(Icons.location_on),
                    label: Text("Ouvrir avec Maps"))
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
                  Text(" €"),
                  SizedBox(width: 10),
                  //
                  Text("il y a X s|m|h|j"),
                ],
              )
          ])
        ],
      ),
    );
  }
}
