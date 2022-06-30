// ignore_for_file: non_constant_identifier_names, avoid_print

import 'dart:async';
import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tucarburesflutter/model/gas_station.dart';

class GasStationsData {
  final String uri_domain = "10.0.2.2:8080";
  final String uri_gas_stations = "gas-stations";

  Future<List<GasStation>> $getGasStations(
      String phonePostion, String maxDistance, String? gasoline) async {
    var url = Uri.http(uri_domain, uri_gas_stations, {
      "phonePosition": phonePostion,
      "maxDistance": maxDistance,
      "gasName": gasoline
    });
    print("POSITION");
    print(phonePostion);
    print("DISTANCE");
    print(maxDistance);
    print("GASOLINE");
    print(gasoline);
    print("URL");
    print(url);
    var response = await http.get(url);
    var jsonResponse = jsonDecode(response.body);
    // print(jsonResponse);
    return GasStationsFromJson(jsonResponse);
  }

  // Future<Map<String, dynamic>> findGasStation(String uuid) async {
  //   var url = Uri.http(uri_domain, '$uri_gas_stations/$uuid');
  //   var response = await http.get(url);
  //   var jsonResponse = jsonDecode(response.body);
  //   return jsonResponse as Map<String, dynamic>;
  // }
  Future<GasStation> $findGasStation(String uuid, String phonePosition) async {
    var url = Uri.http(uri_domain, '$uri_gas_stations/$uuid',
        {"phonePosition": phonePosition});
    print(url);
    var response = await http.get(url);
    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse);
    return GasStation.fromJson(jsonResponse);
  }
  // GasStation $findGasStation(String uuid) {
  //   var gasStation = fakeGasStation.firstWhere((e) => e.id == uuid);
  //   return gasStation;
  // }

  Future<GasStation> $getMyGasStation(String phonePosition) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("favoriGasStationUuid", "62bc803329c1957f122ce989");
    String? uuid = prefs.getString("favoriGasStationUuid");
    print(uuid);
    return await $findGasStation(
        uuid ?? "62bd57e0c6278564f9802010", phonePosition);
  }
}
