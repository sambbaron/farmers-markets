import 'dart:async';

import 'package:angular2/angular2.dart';

import 'package:farmers_markets/src/services/requester.dart';

class MessageViewModel {
  final String messageClass;
  final String text;

  const MessageViewModel(this.text, [this.messageClass = "danger"]);

  String toString() => text;
}

@Injectable()
class ViewContextService {
  final List<MessageViewModel> messages = [];
  bool progressOn = false;

  Future<ExtendedResponse> runRequest(
      Future<ExtendedResponse<dynamic>> requestMethod(),
      {String errorClass, bool runProgress: true}) async {
    if (runProgress) {
      progressOn = true;
    }

    var response = await requestMethod();
    var responseErrors = response.errors
        .map((errorString) => new MessageViewModel(errorString, errorClass));
    messages.addAll(responseErrors);

    if (runProgress) {
      progressOn = false;
    }

    return response;
  }
}
