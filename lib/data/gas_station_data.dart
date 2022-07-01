// ignore_for_file: non_constant_identifier_names, avoid_print

import 'dart:async';
import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tucarburesflutter/model/gas_station.dart';
import 'package:tucarburesflutter/model/statement.dart';

class GasStationsData {
  final String uri_domain = "10.0.2.2:8080";
  final String uri_gas_stations = "gas-stations";

  Future<List<GasStation>> getGasStations(
      String phonePostion, String maxDistance, String? gasoline) async {
    Map<String, dynamic> params;
    if (gasoline == "") {
      params = {
        "phonePosition": phonePostion,
        "maxDistance": maxDistance,
      };
    } else {
      params = {
        "phonePosition": phonePostion,
        "maxDistance": maxDistance,
        "gasName": gasoline,
      };
    }

    var url = Uri.http(uri_domain, uri_gas_stations, params);
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
    print(jsonResponse);
    return GasStationsFromJson(jsonResponse);
  }

  postStatement(Statement statement) async {
    var url = Uri.http(uri_domain, "${statement.gasStationId}/add");
    print(statement.gasStationId);
    print(url);
    var body = jsonEncode(statement);
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    print(response.statusCode);
  }

  // Future<Map<String, dynamic>> findGasStation(String uuid) async {
  //   var url = Uri.http(uri_domain, '$uri_gas_stations/$uuid');
  //   var response = await http.get(url);
  //   var jsonResponse = jsonDecode(response.body);
  //   return jsonResponse as Map<String, dynamic>;
  // }
  Future<GasStation> findGasStation(String uuid, String phonePosition) async {
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

  Future<GasStation> getMyGasStation(String phonePosition) async {
    final prefs = await SharedPreferences.getInstance();
    String? uuid = prefs.getString("favoriGasStationId");
    print("UUID");
    print(uuid);
    if (uuid != null) {
      print("FAVORI GASSTATION FROM SHARED PREFERENCE");
      return await findGasStation(uuid, phonePosition);
    } else {
      print("FIRST GASSTATION FROM GETSTATIONS");
      List<GasStation> gasStations =
          await getGasStations(phonePosition, "50", "");
      return gasStations[0];
    }
  }
}
