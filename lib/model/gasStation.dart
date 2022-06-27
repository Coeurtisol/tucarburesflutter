import 'gasoline.dart';

class GasStation {
  final String id;
  final String brand;
  final String name;
  final List<Gasoline> gasolineList;
  final String lane;
  final String zipCode;
  final String city;
  final String latitude;
  final String longitude;

  const GasStation({
    required this.id,
    required this.brand,
    required this.name,
    required this.gasolineList,
    required this.lane,
    required this.zipCode,
    required this.city,
    required this.latitude,
    required this.longitude,
  });
}