import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';

class ExtendedResponse<ParsedResponseType> {
  bool success;
  Response _response;
  var decodedBody;
  ParsedResponseType parsedResponse;
  final List<String> errors = [];

  ExtendedResponse.fromRequester(this._response)
      : success = _response.statusCode == 200 {
    if (success) {
      if (_response.body?.isNotEmpty == true) {
        decodedBody = JSON.decode(_response.body);
      }
    } else {
      errors.add(_response.body);
    }
  }

  ExtendedResponse.toSuccess() : success = true;

  ExtendedResponse.toFailure([String errorMessage]) : success = false {
    if (errorMessage != null) {
      errors.add(errorMessage);
    }
  }

  Response get response => _response;

  bool get hasErrors => errors?.isNotEmpty == true;

  List decodedBodyList([String key = "results"]) {
    List list;
    if (decodedBody is Map) {
      list = decodedBody["results"];
    }
    return list ?? [];
  }

  dynamic firstInDecodedList([String key = "results"]) {
    var list = decodedBodyList(key);
    return list.isNotEmpty ? list.first : null;
  }
}

class Requester {
  static const Duration timeout = const Duration(seconds: 60);

  final Client _client;

  Requester(this._client);

  Future<ExtendedResponse> send(BaseRequest request) async {
    var stream = await _client.send(request);
    var response = await Response.fromStream(stream);
    var extendedResponse = new ExtendedResponse.fromRequester(response);
    return extendedResponse;
  }
}
