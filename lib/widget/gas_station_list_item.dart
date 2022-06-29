import "package:flutter/material.dart";
import 'package:tucarburesflutter/model/gas_station.dart';
import 'package:tucarburesflutter/screen/gas_station_page.dart';

class GasStationRechercheItemWidget extends StatelessWidget {
  const GasStationRechercheItemWidget({Key? key, required this.gasStation})
      : super(key: key);

  final GasStation gasStation;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(8),
        // padding: const EdgeInsets.all(4),
        child: GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => GasStationPage(uuid: gasStation.id))),
          child: Column(
            children: [
              Row(
                children: [
                  Text(gasStation.name),
                  const Text("(à X km)"),
                ],
              ),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    for (var gasoline in gasStation.gasolineList)
                      Row(
                        children: [
                          Text(gasoline.name),
                          const SizedBox(width: 5),
                          Text("(${gasoline.code})"),
                          const Text(" 2.319",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          const Text(" €"),
                          const SizedBox(width: 10),
                          const Text("il y a X s|m|h|j"),
                        ],
                      )
                  ])
            ],
          ),
        ));
  }
}
