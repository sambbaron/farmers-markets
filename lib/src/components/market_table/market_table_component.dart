import 'dart:async';

import 'package:angular2/angular2.dart';

import 'package:farmers_markets/src/components/base/view_context_service.dart';
import 'package:farmers_markets/src/models/farmers_market_model.dart';
import 'package:farmers_markets/src/models/geolocation_model.dart';
import 'package:farmers_markets/src/services/usda_markets_service.dart';

@Component(
    selector: 'market-table',
    templateUrl: 'market_table_component.html',
    styleUrls: const ['market_table_component.css'],
    directives: const [
      CORE_DIRECTIVES,
    ],
    providers: const [
      UsdaMarketsService
    ])
class MarketTableComponent implements OnInit {
  final List<String> apps = const ["dev.integration.famis", "johns.app"];

  final ViewContextService _viewContextService;
  final UsdaMarketsService _usdaMarketsService;

  List<FarmersMarketModel> markets = [];

  MarketTableComponent(this._viewContextService, this._usdaMarketsService);

  GeoLocationModel _geoLocation;

  GeoLocationModel get geoLocation => _geoLocation;

  @Input()
  set geoLocation(GeoLocationModel geoLocation) {
    _geoLocation = geoLocation;
    ngOnInit();
  }

  bool get hasMarkets => markets?.isNotEmpty == true;

  bool get noMarkets => !hasMarkets;

  Future ngOnInit() async {
    if (geoLocation.isEmpty) {
      markets = [];
      return;
    }

    var requestMethod = () => _usdaMarketsService.getAllByLocation(
        geoLocation.latitude, geoLocation.longitude);
    var response = await _viewContextService.runRequest(requestMethod);
    markets = response.parsedResponse;
  }
}
