import 'package:flutter/material.dart';
import 'package:technomade/src/core/router/router_observer.dart';

class NavigatorObserversFactory {
  const NavigatorObserversFactory._();

  static List<NavigatorObserver> call() => [
        RouterObserver(),
      ];
}
