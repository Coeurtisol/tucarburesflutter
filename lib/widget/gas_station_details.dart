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
  void updateStatementPrice(
      GasStation gasStation, String statementId, double newPrice) {
    print(gasStation);
    print(statementId);
    print(newPrice);
    Map<String, dynamic> jsonGasStation = gasStation.toJson();
    // print(jsonGasStation.update(["StatementList"].firstWhere((statement) => statement["id"] == statementId ), (value) => null));
    print(DateTime.now().toIso8601String());
  }

  @override
  Widget build(BuildContext context) {
    final gasStation = widget.gasStation;
    return Center(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                child: Column(
                  children: [
                    Text(gasStation.brand),
                    Text(gasStation.name),
                    Text("(à ${gasStation.distance?.toStringAsFixed(2)} km)"),
                  ],
                ),
              ),
              // SizedBox(width: 20),
              Flexible(
                  child: Column(children: [
                Text(gasStation.lane),
                Text(gasStation.zipCode),
                Text(gasStation.city),
                ElevatedButton.icon(
                    onPressed: () => MapsLauncher.launchCoordinates(
                        gasStation.latitude, gasStation.longitude),
                    icon: Icon(Icons.location_on),
                    label: Text("Ouvrir avec Maps"))
              ]))
            ],
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: <Widget>[
            for (var statement in gasStation.statementList)
              ElevatedButton(
                child: Container(
                  margin: EdgeInsets.all(4),
                  child: Row(
                    children: [
                      Text(DateUtil().convertDate(statement.localDate)),
                      SizedBox(width: 5),
                      Text(statement.gasoline.name),
                      SizedBox(width: 5),
                      Text("(${statement.gasoline.code}) :"),
                      SizedBox(width: 5),
                      Text(statement.price.toString(),
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(" €"),
                    ],
                  ),
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          scrollable: true,
                          title:
                              Text('Le prix a changé?', textScaleFactor: 1.5),
                          content: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Form(
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    gasStation.name,
                                    textScaleFactor: 1.2,
                                  ),
                                  Text(gasStation.city),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    initialValue: statement.price.toString(),
                                    decoration: InputDecoration(
                                      labelText:
                                          'Prix observé pour le ${statement.gasoline.name}',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          actions: [
                            ElevatedButton(
                                child: Text("Valider"),
                                onPressed: () => updateStatementPrice(
                                    gasStation, statement.id, statement.price))
                          ],
                        );
                      });
                },
              ),
          ]),
        ],
      ),
    );
  }
}
