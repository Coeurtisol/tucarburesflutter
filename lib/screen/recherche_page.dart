// ignore_for_file: prefer_const_constructors, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tucarburesflutter/data/gas_station_data.dart';
import 'package:tucarburesflutter/model/gas_station.dart';
import 'package:tucarburesflutter/util/position_util.dart';
import 'package:tucarburesflutter/widget/circular_progress_indicator_custom.dart';
import 'package:tucarburesflutter/widget/gas_station_list_item.dart';

class RecherchePage extends StatefulWidget {
  @override
  _RecherchePageState createState() => _RecherchePageState();
}

class _RecherchePageState extends State<RecherchePage> {
  late Position? _currentPosition = null;
  late int _distance = int.parse(defaultDistance);
  late String _gasoline = "";
  final TextEditingController _controller = TextEditingController();
  final String defaultDistance = "50";
  final List<String> gasolines = [
    "Sans plomb 95",
    "Sans plomb 98",
    "Superéthanol",
    "Gasoil",
    "GPL"
  ];

  Future<List<GasStation>> getGasStations() async {
    String stringPosition = await PositionUtil().getStringPosition();
    return await GasStationsData()
        .$getGasStations(stringPosition, _distance.toString(), _gasoline);
  }

  void refreshByDistance(String distance) {
    setState(() {
      if (distance == "" || distance == "0") {
        distance = defaultDistance;
        _controller.text = "";
      }
      _distance = int.parse(distance);
    });
  }

  void refreshByGasoline(String gasoline) {
    setState(() {
      _gasoline = gasoline;
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _controller.text = defaultDistance.toString();
    });
    // _getCurrentLocation();
    // getGasStations();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData == true) {
            final gasStations = snapshot.data as List<GasStation>;
            return Column(
              children: [
                // ignore: prefer_const_constructors
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextField(
                    controller: _controller,
                    onSubmitted: refreshByDistance,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: "Distance maximale", hintText: "50"),
                  ),
                ),
                Wrap(children: <Widget>[
                  for (var gasoline in gasolines)
                    Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                        child: ElevatedButton(
                          onPressed: () => refreshByGasoline(gasoline),
                          style: ElevatedButton.styleFrom(
                              primary: _gasoline == gasoline
                                  ? Colors.green
                                  : Colors.grey),
                          child: Text(gasoline),
                        ))
                ]),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: gasStations.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GasStationRechercheItemWidget(
                      gasStation: gasStations[index],
                      gasolineFilter: _gasoline,
                    );
                  },
                )
              ],
            );
          } else {
            return const CilcularProgressIndicationCustom(
                text: "Chargement des stations");
          }
        },
        future: getGasStations());
  }
}
