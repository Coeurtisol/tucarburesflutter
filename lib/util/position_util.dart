import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PositionUtil {
  Future<Position> getPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  }

  Future<String> getStringPosition() async {
    String stringPosition;
    String? lastStringPosition = await getStringPositionFromSharedPreferences();
    if (lastStringPosition != null) {
      print("POSITION FROM SHARED PREFERENCE");
      stringPosition = lastStringPosition;
    } else {
      print("POSITION FROM GEOLOCATOR");
      Position position = await getPosition();
      stringPosition = "${position.latitude}-${position.longitude}";
      setStringPositionToSharedPreferences(stringPosition);
    }
    return stringPosition;
  }

  dynamic getStringPositionFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    String? position = prefs.getString("position");
    String? positionDateTime = prefs.getString("positionDateTime");
    if (positionDateTime == null) {
      print("POSITION DATETIME NULL");
      return null;
    }
    DateTime to = DateTime.now();
    DateTime from = DateTime.parse(positionDateTime);
    if (to.difference(from).inSeconds > 60) {
      print("POSITION DATETIME EXPIRED");
      return null;
    }
    print("POSITION DATETIME GOOD");
    return position;
  }

  void setStringPositionToSharedPreferences(String stringPosition) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("positionDateTime", DateTime.now().toString());
    await prefs.setString("position", stringPosition);
  }
}
