import 'package:flutter/material.dart';

class NavigatorLocal {

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static Future<void> goTo(Widget page) {
    return navigatorKey.currentState!.push(
      MaterialPageRoute(builder: (_) => page)
    );
  }

  static void goBack() => navigatorKey.currentState!.pop();

  static Future<void> pushNamed(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!.pushNamed(routeName, arguments: arguments);
  }
}
