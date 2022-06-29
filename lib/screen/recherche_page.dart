import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tucarburesflutter/data/gas_station_data.dart';
import 'package:tucarburesflutter/model/gas_station.dart';
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
    return await GasStationsData().$getGasStations(
        "${_currentPosition?.latitude}-${_currentPosition?.longitude}", "10");
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    getGasStations();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData == true) {
            // print(snapshot.data);
            final gasStations = snapshot.data as List<GasStation>;
            // print(gasStation.gasolineList);
            // final gasStation = snapshot.data as Map<String, dynamic>;
            // final gasolineList = gasStation["gasolineList"] as List<Map<String, dynamic>>;
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return GasStationRechercheItemWidget(
                    gasStation: gasStations[index]);
              },
              itemCount: gasStations.length,
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Chargement des informations de ma station'),
                  CircularProgressIndicator()
                ],
              ),
            );
          }
        },
        future: getGasStations());
  }
}
