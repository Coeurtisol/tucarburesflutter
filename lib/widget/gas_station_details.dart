// ignore_for_file: prefer_const_literals_to_create_immutables, library_prefixes

import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tucarburesflutter/data/gas_station_data.dart';
import 'package:tucarburesflutter/model/gas_station.dart';
import 'package:tucarburesflutter/model/statement.dart';
import 'package:tucarburesflutter/widget/statement_list_item.dart';

class GasStationDetails extends StatefulWidget {
  final GasStation gasStation;
  final Function refresh;

  const GasStationDetails(
      {Key? key, required this.gasStation, required this.refresh})
      : super(key: key);

  @override
  State<GasStationDetails> createState() => _GasStationDetailsState();
}

class _GasStationDetailsState extends State<GasStationDetails> {
  void updateStatementPrice(
      String gasStationId, Statement statement, double newPrice) async {
    // TODO CORRIGER BASE DE DONNEE AVEC GASSTATIONID SUR LES STATEMENTS
    statement.gasStationId = gasStationId;
    statement.price = newPrice;
    await GasStationsData().postStatement(statement);
    widget.refresh();
  }

  void setFavoriGasStationId(String gasStationId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("favoriGasStationId", gasStationId);
    widget.refresh();
  }

  @override
  Widget build(BuildContext context) {
    final gasStation = widget.gasStation;
    return Center(
      child: Column(
        children: [
          ElevatedButton.icon(
              onPressed: () => setFavoriGasStationId(gasStation.id),
              icon: const Icon(Icons.favorite_border_outlined),
              label: const Text("Définir comme favori")),
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
                    icon: const Icon(Icons.location_on),
                    label: const Text("Ouvrir avec Maps"))
              ]))
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              for (var statement in gasStation.statementList)
                StatementListItem(
                    gasStation: gasStation,
                    statement: statement,
                    updateStatementPrice: updateStatementPrice)
            ],
          ),
        ],
      ),
    );
  }
}
