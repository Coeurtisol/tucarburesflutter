import "package:flutter/material.dart";
import 'package:tucarburesflutter/model/gas_station.dart';

class GasStationWidget extends StatelessWidget {
  const GasStationWidget({Key? key, required this.gasStation})
      : super(key: key);

  final GasStation gasStation;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(4),
      child: Row(children: [
        Text(gasStation.brand),
        SizedBox(width: 10),
        Text(gasStation.name)
      ]),
    );
  }
}
