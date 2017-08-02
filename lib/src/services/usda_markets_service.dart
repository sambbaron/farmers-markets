import 'dart:async';

import 'package:angular2/angular2.dart';
import 'package:http/http.dart';

import 'package:farmers_markets/src/models/farmers_market_model.dart';
import 'package:farmers_markets/src/services/requester.dart';

@Injectable()
class UsdaMarketsService {
  static const String url =
      "http://search.ams.usda.gov/farmersmarkets/v1/data.svc";

  final Requester _requester;

  UsdaMarketsService(this._requester);

  Future<ExtendedResponse<List<FarmersMarketModel>>> getAllByLocation(
      String lat, String lng) async {
    Map params = {"lat": lat, "lng": lng};
    var uri = Uri.parse("$url/locSearch").replace(queryParameters: params);
    var request = new Request("GET", uri);
    var response = await _requester.send(request);

    if (response.success) {
      response.parsedResponse = response
          .decodedBodyList()
          .map((json) => new FarmersMarketModel.fromSearchJson(json))
          .toList();
    }

    return response;
  }

  Future<ExtendedResponse<FarmersMarketModel>> getOneDetail(
      FarmersMarketModel farmersMarket) async {
    Map params = {"id": farmersMarket.id};
    var uri = Uri.parse("$url/mktDetail").replace(queryParameters: params);
    var request = new Request("GET", uri);
    var response = await _requester.send(request);

    if (response.success) {
      farmersMarket.fromDetailJson(response.decodedBody["marketdetails"]);
    }

    return response;
  }
}
