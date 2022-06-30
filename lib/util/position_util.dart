import 'package:geolocator/geolocator.dart';

class PositionUtil {
  Future<Position> getPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  }

  Future<String> getStringPosition() async {
    Position position = await getPosition();
    String stringPosition = "${position.latitude}-${position.longitude}";
    return stringPosition;
  }
}
