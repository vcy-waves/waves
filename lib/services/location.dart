import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class LocatingService {
  static const String _apiKey = 'AIzaSyDraVDjDdbDUXfQlxU6oL396YUx_noYhrs';

  static Future<String> _findUserActualPlaceId({
    required double latitude,
    required double longitude,
  }) async {
    final Uri url = Uri.parse(
      'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&language=zh-TW &location_type=ROOFTOP&result_type=street_address&key=$_apiKey&mode=bicycling',
    );
    var source = await http.get(url);
    final data = jsonDecode(source.body);
    if (data['status'] != 'OK') {
      return '';
    } else {
      return data['results'][0]['place_id'];
    }
  }

  static Future<String> calculateArrivalTime({
    required double destinationLatitude,
    required double destinationLongitude,
  }) async {
    Position position = await determinePosition();
    final String originPlaceId = await _findUserActualPlaceId(
      latitude: position.latitude,
      longitude: position.longitude,
    );
    final String destinationPlaceId = await _findUserActualPlaceId(
      longitude: destinationLongitude,
      latitude: destinationLatitude,
    );
    if (originPlaceId == '') {
      throw (Exception('originPlaceId not found'));
    }
    if (destinationPlaceId == '') {
      throw (Exception('destinationPlaceId not found'));
    }
    final Uri url = Uri.parse(
        'https://maps.googleapis.com/maps/api/distancematrix/json?destinations=place_id:$destinationPlaceId&origins=place_id:$originPlaceId&key=$_apiKey');
    var source = await http.get(url);
    final data = jsonDecode(source.body);
    if (data['status'] != 'OK') {
      throw (Exception('Distance Matrix Error'));
    } else {
      String duration = data['rows'][0]['elements'][0]['duration']['text'];
      return duration;
    }
  }

  static Future<Position> determinePosition() async {
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
