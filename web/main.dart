// Copyright (c) 2017, sambaron. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:angular2/platform/browser.dart';
import 'package:http/browser_client.dart';
import 'package:http/http.dart';

import 'package:farmers_markets/app_component.dart';
import 'package:farmers_markets/src/services/requester.dart';

void main() {
  var client = new BrowserClient();
  var requester = new Requester(client);

  bootstrap(AppComponent, [
    provide(Client, useValue: client),
    provide(Requester, useValue: requester)
  ]);
}
