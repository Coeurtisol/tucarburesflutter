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

  _getCurrentLocation() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position);
    setState(() {
      _currentPosition = position;
    });
  }

  Future<List<GasStation>> getGasStations() async {
    String stringPosition = await PositionUtil().getStringPosition();
    return await GasStationsData().$getGasStations(stringPosition, "10");
  }

  @override
  void initState() {
    super.initState();
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
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return GasStationRechercheItemWidget(
                    gasStation: gasStations[index]);
              },
              itemCount: gasStations.length,
            );
          } else {
            return const CilcularProgressIndicationCustom(
                text: "Chargement des stations");
          }
        },
        future: getGasStations());
  }
}
