import 'package:tucarburesflutter/model/gasoline.dart';

List<Statement> StatementsFromJson(dynamic str) =>
    List<Statement>.from((str).map((x) => Statement.fromJson(x)));

List<Map<String, dynamic>> JsonFromStatements(List<Statement> statement) =>
    List<Map<String, dynamic>>.from((statement).map((x) => x.toJson()));

class Statement {
  late String id;
  late String gasStationId;
  late Gasoline gasoline;
  late String localDate;
  late double price;

  Statement({
    required this.id,
    required this.gasStationId,
    required this.gasoline,
    required this.localDate,
    required this.price,
  });

  Statement.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gasStationId = json['gasStationId'];
    gasoline = Gasoline.fromJson(json['gasoline']);
    localDate = json['localDate'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};

    json["id"] = id;
    json["gasStationId"] = gasStationId;
    json["gasoline"] = gasoline.toJson();
    json["localDate"] = localDate;
    json["price"] = price;

    return json;
  }
}
