import 'package:tucarburesflutter/model/statement.dart';

import 'gasoline.dart';

List<GasStation> GasStationsFromJson(dynamic str) =>
    List<GasStation>.from((str).map((x) => GasStation.fromJson(x)));

class GasStation {
  late String id;
  late String brand;
  late String name;
  late List<Gasoline> gasolineList;
  late List<Statement> statementList;
  late String lane;
  late String zipCode;
  late String city;
  late double latitude;
  late double longitude;
  late double? distance;

  GasStation({
    required this.id,
    required this.brand,
    required this.name,
    required this.gasolineList,
    required this.statementList,
    required this.lane,
    required this.zipCode,
    required this.city,
    required this.latitude,
    required this.longitude,
    this.distance,
  });

  GasStation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brand = json['brand'];
    name = json['name'];
    gasolineList = GasolinesFromJson(json['gasolineList']);
    statementList = StatementsFromJson(json['statementList']);
    lane = json['lane'];
    zipCode = json['zipCode'];
    city = json['city'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};

    json["id"] = id;
    json["brand"] = brand;
    json["name"] = name;
    json["gasolineList"] = JsonFromGasolines(gasolineList);
    json["statementList"] = JsonFromStatements(statementList);
    json["lane"] = lane;
    json["zipCode"] = zipCode;
    json["city"] = city;
    json["latitude"] = latitude;
    json["longitude"] = longitude;
    json["distance"] = distance;

    return json;
  }
}
