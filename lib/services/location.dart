import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class LocatingService {
  static const String apiKey = 'AIzaSyDraVDjDdbDUXfQlxU6oL396YUx_noYhrs';
  String timeZone = '';

  static Future<String> _findUserActualPlaceId() async {
    final Position position = await _determinePosition();
    print(position.longitude);
    print(position.latitude);
    final Uri url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&language=zh-TW &location_type=ROOFTOP&result_type=street_address&key=$apiKey');
    var source = await http.get(url);
    final data = jsonDecode(source.body);
    return data['results'][0]['place_id'];
  }


  static Future<void> calculateDistance({required destinationPlaceId}) async {
    final String originPlaceId = await _findUserActualPlaceId();
    final Uri url = Uri.parse(
        'https://maps.googleapis.com/maps/api/distancematrix/json?destinations=place_id:ChIJgUbEo8cfqokR5lP9_Wh_DaM &origins=place_id:$originPlaceId &key=$apiKey');
    var source = await http.get(url);
    print(source.body);
  }

  static Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }
}
