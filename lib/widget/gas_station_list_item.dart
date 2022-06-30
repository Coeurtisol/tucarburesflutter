import "package:flutter/material.dart";
import 'package:tucarburesflutter/model/gas_station.dart';
import 'package:tucarburesflutter/screen/gas_station_page.dart';
import 'package:tucarburesflutter/util/date_util.dart';

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
                  const SizedBox(width: 10),
                  Text("(à ${gasStation.distance?.toStringAsFixed(2)} km)"),
                ],
              ),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    for (var statement in gasStation.statementList)
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(DateUtil()
                                  .convertDate(statement.localDate.toString())),
                              const SizedBox(width: 10),
                              Text(statement.gasoline.name),
                              const SizedBox(width: 5),
                              Text("(${statement.gasoline.code} :)"),
                              const SizedBox(width: 5),
                              Text(statement.price.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              const Text(" €"),
                            ],
                          ),
                        ],
                      )
                  ])
            ],
          ),
        ));
  }
}
