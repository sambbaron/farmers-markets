// Copyright (c) 2017, sambaron. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/angular2.dart';
import 'package:angular2/platform/common.dart';
import 'package:angular2/router.dart';
import 'package:ng_bootstrap/ng_bootstrap.dart';

import 'package:farmers_markets/src/components/market_home/market_home_component.dart';
import 'package:farmers_markets/src/components/base/view_helper_service.dart';

@Component(
    selector: 'my-app',
    templateUrl: 'app_component.html',
    styleUrls: const ['app_component.css'],
    directives: const [CORE_DIRECTIVES, ROUTER_DIRECTIVES, BS_DIRECTIVES],
    providers: const [
      ROUTER_PROVIDERS,
      ViewHelperService,
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
  final ViewHelperService _viewHelperService;

  AppComponent(this._viewHelperService);

  List<ErrorViewModel> get errors => _viewHelperService.errors;

  bool get showProgress => _viewHelperService.progressOn;

  void closeError(ErrorViewModel errorView) {
    _viewHelperService.errors.remove(errorView);
  }
}
