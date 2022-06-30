List<Gasoline> GasolinesFromJson(dynamic str) =>
    List<Gasoline>.from((str).map((x) => Gasoline.fromJson(x)));

List<Map<String, dynamic>> JsonFromGasolines(List<Gasoline> gasoline) =>
    List<Map<String, dynamic>>.from((gasoline).map((x) => x.toJson()));

class Gasoline {
  late String name;
  late String code;

  Gasoline({
    required this.name,
    required this.code,
  });

  Gasoline.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};

    json["name"] = name;
    json["code"] = code;

    return json;
  }
}
