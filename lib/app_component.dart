// Copyright (c) 2017, sambaron. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/angular2.dart';
import 'package:angular2/platform/common.dart';
import 'package:angular2/router.dart';
import 'package:ng_bootstrap/ng_bootstrap.dart';

import 'package:farmers_markets/src/components/market_home/market_home_component.dart';
import 'package:farmers_markets/src/components/base/view_context_service.dart';

@Component(
    selector: 'my-app',
    templateUrl: 'app_component.html',
    styleUrls: const ['app_component.css'],
    directives: const [CORE_DIRECTIVES, ROUTER_DIRECTIVES, BS_DIRECTIVES],
    providers: const [
      ROUTER_PROVIDERS,
      ViewContextService,
      const Provider(LocationStrategy, useClass: HashLocationStrategy)
    ])
@RouteConfig(const [
  const Route(
      path: '/markets',
      name: 'MarketHome',
      component: MarketHomeComponent,
      useAsDefault: true),
])
class AppComponent {
  final ViewContextService _viewContextService;

  AppComponent(this._viewContextService);

  List<MessageViewModel> get messages => _viewContextService.messages;

  bool get showProgress => _viewContextService.progressOn;

  void closeMessage(MessageViewModel message) {
    _viewContextService.messages.remove(message);
  }
}
