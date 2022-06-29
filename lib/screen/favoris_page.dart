// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_import, library_prefixes

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
  // final GasStation gasStation = GasStationsData().$findGasStation("2");

  Future<GasStation> getGasStation() async {
    return await GasStationsData().$findGasStation("62bbfab18ba8ee41cdcca422");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData == true) {
            print(snapshot.data);
            final gasStation = snapshot.data as GasStation;
            print(gasStation.gasolineList);
            // final gasStation = snapshot.data as Map<String, dynamic>;
            // final gasolineList = gasStation["gasolineList"] as List<Map<String, dynamic>>;
            return Center(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          // Text(gasStation["brand"]),
                          // Text(gasStation["name"]),
                          // Text("(à X km)"),
                          // // Text("(à ${gasStation.distance} km)"),
                          Text(gasStation.brand),
                          Text(gasStation.name),
                          Text("(à X km)"),
                          // Text("(à ${gasStation.distance} km)"),
                        ],
                      ),
                      SizedBox(width: 20),
                      Column(children: [
                        // Text(gasStation["lane"]),
                        // Text(gasStation["zipCode"]),
                        // Text(gasStation["city"]),
                        Text(gasStation.lane),
                        Text(gasStation.zipCode),
                        Text(gasStation.city),
                        ElevatedButton.icon(
                            onPressed: () => MapsLauncher.launchCoordinates(
                                // double.parse(gasStation["latitude"]),
                                // double.parse(gasStation["longitude"])),
                                gasStation.latitude,
                                gasStation.longitude),
                            icon: Icon(Icons.location_on),
                            label: Text("Ouvrir avec Maps"))
                      ])
                    ],
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        for (var gasoline in gasStation.gasolineList)
                          Row(
                            children: [
                              // Text(gasoline.name + ' (' + gasoline.code + ') :'),
                              // Text('${gasoline["name"]} :'),
                              Text(gasoline.name),
                              SizedBox(width: 5),
                              Text("(${gasoline.code})"),
                              // Text(gasoline["price"],
                              // Text(gasoline.price,
                              //     style:
                              //         TextStyle(fontWeight: FontWeight.bold)),
                              Text(" 2.319",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
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
