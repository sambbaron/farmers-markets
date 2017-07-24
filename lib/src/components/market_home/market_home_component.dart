import 'dart:async';

import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';

import 'package:farmers_markets/src/components/base/view_helper_service.dart';
import 'package:farmers_markets/src/components/market_table/market_table_component.dart';
import 'package:farmers_markets/src/models/geolocation_model.dart';
import 'package:farmers_markets/src/services/geocoding_service.dart';

@Component(
    selector: 'market-home',
    templateUrl: 'market_home_component.html',
    styleUrls: const [
      'market_home_component.css'
    ],
    directives: const [
      CORE_DIRECTIVES,
      ROUTER_DIRECTIVES,
      FORM_DIRECTIVES,
      MarketTableComponent
    ],
    providers: const [
      GeocodingService
    ])
class MarketHomeComponent implements OnInit {
  final RouteParams _routeParams;
  final Router _router;
  final ViewHelperService _viewHelperService;
  final GeocodingService _geocodingService;

  String lat;
  String lng;
  GeoLocationModel geoLocation = new GeoLocationModel();

  MarketHomeComponent(this._routeParams, this._router, this._viewHelperService,
      this._geocodingService);

  Future ngOnInit() async {
    lat = _routeParams.get("lat");
    lng = _routeParams.get("lng");
    if (lat != null && lng != null) {
      var requestMethod = () => _geocodingService.getLocationByLatLng(lat, lng);
      var response = await _viewHelperService.runRequest(requestMethod);
      if (response.parsedResponse != null) {
        geoLocation = response.parsedResponse;
      }
    }
  }

  Future getCurrentPosition() async {
    var requestMethod = () => _geocodingService.getFromBrowser();
    var response = await _viewHelperService.runRequest(requestMethod);
    if (response.parsedResponse != null) {
      geoLocation = response.parsedResponse;
    }
    route();
  }

  Future updateAddress() async {
    var requestMethod = () =>
        _geocodingService.getLocationByAddress(geoLocation.formattedAddress);
    var response = await _viewHelperService.runRequest(requestMethod);
    if (response.parsedResponse != null) {
      geoLocation = response.parsedResponse;
    }
    route();
  }

  void route() {
    if (geoLocation.isEmpty) return;
    _router.navigate(["MarketHome", geoLocation.toJson()]);
  }
}
