import 'dart:developer';

import 'package:flutter/material.dart';

class MyObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log('MyObserver.didPush(route: $route, previousRoute: $previousRoute)');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log('MyObserver.didPop(route: $route, previousRoute: $previousRoute)');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log('MyObserver.didRemove(route: $route, previousRoute: $previousRoute)');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    log('MyObserver.didReplace(route: $newRoute, previousRoute: $oldRoute)');
  }

  @override
  void didStartUserGesture(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log('MyObserver.didStartUserGesture(route: $route, previousRoute: $previousRoute)');
  }

  @override
  void didStopUserGesture() {
    log('MyObserver.didStopUserGesture()');
  }
}
