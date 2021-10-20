import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

import 'api_key.dart';

class Location {
  late double latitude;
  late double longitude;

  void checkingPermission() async {
    await Geolocator.openAppSettings();
    await Geolocator.openLocationSettings();
  }

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      // return position;
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print(e);
    }
  }

  Future<void> getData() async {
    http.Response response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric'));
    if (response.statusCode == 200) {
      String data = response.body;
      print(data);
    } else {
      print(response.statusCode);
    }
  }
}
