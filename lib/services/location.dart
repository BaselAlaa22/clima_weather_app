import 'package:geolocator/geolocator.dart';

class Location {
  static double latitude;
  static double longitude;

  static Future<Position> getCurrentLocation() async {
    Position position;

    position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.lowest);
    return position;
  }
}
