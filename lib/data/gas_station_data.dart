import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:tucarburesflutter/fakedata/fakedata_gasstation.dart';
import 'package:tucarburesflutter/model/gas_station.dart';

class GasStationsData {
  final String authToken = "ac415c926075ad3b5cd2048059e17352";

  // Future<Map<String, dynamic>> getGasStations(
  //     int maxDistance, double maxPrice) async {
  //   var uri = Uri.https("api.themoviedb.org", "3/movie/popular",
  //       {"api_key": authToken, "language": "fr-FR"});
  //   var response = await http.get(uri);
  //   Map<String, dynamic> jsonResponse =
  //       jsonDecode(response.body) as Map<String, dynamic>;
  //   return jsonResponse;
  // }

  List<GasStation> getGasStations(int maxDistance, double maxPrice) {
    return fakeGasStation;
  }

  GasStation findGasStation(String uuid) {
    var gasStation = fakeGasStation.firstWhere((e) => e.id == uuid);
    return gasStation;
  }

  // Future<GasStation> $getGasStations(
  //   GasStation gasStation
  //     int maxDistance, double maxPrice) async {
  //   var uri = Uri.https("api.themoviedb.org", "3/movie/popular",
  //       {"api_key": authToken, "language": "fr-FR"});
  //   var response = await http.get(uri);
  //   Map<String, dynamic> jsonResponse =
  //       jsonDecode(response.body) as Map<String, dynamic>;
  //   return ;
  // }
}
