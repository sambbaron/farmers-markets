import 'dart:async';

import 'package:angular2/angular2.dart';

import 'package:farmers_markets/src/services/requester.dart';

class ErrorViewModel {
  final String errorClass;
  final String message;

  const ErrorViewModel(this.message, [this.errorClass]);

  String toString() => message;
}

@Injectable()
class ViewHelperService {
  final List<ErrorViewModel> errors = [];
  bool progressOn = false;

  Future<ExtendedResponse> runRequest(
      Future<ExtendedResponse<dynamic>> requestMethod(),
      {String errorClass: "danger",
      bool runProgress: true}) async {
    if (runProgress) {
      progressOn = true;
    }

    var response = await requestMethod();
    var responseErrors = response.errors
        .map((errorString) => new ErrorViewModel(errorString, errorClass));
    errors.addAll(responseErrors);

    if (runProgress) {
      progressOn = false;
    }

    return response;
  }
}
