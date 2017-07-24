import 'dart:async';
import 'dart:html' show window, Geoposition;

import 'package:angular2/angular2.dart';
import 'package:http/http.dart';

import 'package:farmers_markets/src/models/geolocation_model.dart';
import 'package:farmers_markets/src/services/requester.dart';

@Injectable()
class GeocodingService {
  static const String url = "https://maps.googleapis.com/maps/api/geocode/json";
  static const String apiKey = "AIzaSyAnWIpLfZ3pDD7TO1axrs0Q-P9-TNz0W8E";

  final Requester _requester;

  GeocodingService(this._requester);

  Future<ExtendedResponse<GeoLocationModel>> getLocationByAddress(
      String address) async {
    Map params = {"address": address, "key": apiKey};
    var uri = Uri.parse(url).replace(queryParameters: params);
    var request = new Request("GET", uri);
    var response = await _requester.send(request);

    var jsonResponse = response.firstInDecodedList();
    if (jsonResponse != null) {
      response.parsedResponse = new GeoLocationModel.fromJson(jsonResponse);
    }

    return response;
  }

  Future<ExtendedResponse<GeoLocationModel>> getLocationByLatLng(
      String lat, String lng) async {
    Map params = {"latlng": "$lat,$lng", "key": apiKey};
    var uri = Uri.parse(url).replace(queryParameters: params);
    var request = new Request("GET", uri);
    var response = await _requester.send(request);

    var jsonResponse = response.firstInDecodedList();
    if (jsonResponse != null) {
      response.parsedResponse = new GeoLocationModel.fromJson(jsonResponse);
    }

    return response;
  }

  Future<ExtendedResponse<GeoLocationModel>> getFromBrowser() async {
    var geoposition = await window.navigator.geolocation
        .getCurrentPosition()
        .timeout(new Duration(seconds: 30), onTimeout: () => null)
        .catchError((e) => null);
    if (geoposition is Geoposition) {
      return getLocationByLatLng(geoposition.coords.latitude.toString(),
          geoposition.coords.longitude.toString());
    } else {
      return new ExtendedResponse.toFailure(
          "Unable to access current location from browser");
    }
  }
}
