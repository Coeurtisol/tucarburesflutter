import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:tucarburesflutter/fakedata/fakedata_gasstation.dart';
import 'package:tucarburesflutter/model/gas_station.dart';

class GasStationsData {
  final String uri_domain = "10.0.2.2:8080";
  final String uri_gas_stations = "gas-stations";

  Future<List<GasStation>> $getGasStations() async {
    var url = Uri.http(uri_domain, uri_gas_stations);
    var response = await http.get(url);
    var jsonResponse = jsonDecode(response.body);
    return GasStationsFromJson(jsonResponse); jsonResponse;
  }

  Future<Map<String, dynamic>> findGasStation(String uuid) async {
    var url = Uri.http(uri_domain, uri_gas_stations + '/' + uuid);
    var response = await http.get(url);
    var jsonResponse = jsonDecode(response.body);
    return jsonResponse as Map<String, dynamic>;
  }
  Future<GasStation> $findGasStation(String uuid) async {
    var url = Uri.http(uri_domain, uri_gas_stations + '/' + uuid);
    var response = await http.get(url);
    var jsonResponse = jsonDecode(response.body);
    return GasStation.fromJson(jsonResponse);
  }
  // GasStation $findGasStation(String uuid) {
  //   var gasStation = fakeGasStation.firstWhere((e) => e.id == uuid);
  //   return gasStation;
  // }
}
