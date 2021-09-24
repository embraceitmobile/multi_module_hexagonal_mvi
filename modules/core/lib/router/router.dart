import 'package:flutter/material.dart';

typedef RouteBuilder = Widget Function(BuildContext context, Object? args);

mixin IRouter {
  Map<String, RouteBuilder> get routes;

  Widget? to({
    required BuildContext context,
    required String route,
    Object? args,
  });
}

class RouteHandler {
  final List<IRouter> routers;
  late final Map<String, IRouter> _routersMap;

  RouteHandler(this.routers) {
    for (final router in routers) {
      for (final route in router.routes.keys) {
        _routersMap.putIfAbsent(route, () => router);
      }
    }
  }

  Route onGenerateRoute(RouteSettings settings) {
    if (settings.name == null) throw Exception('Route name not provided');

    return MaterialPageRoute(
      settings: settings,
      builder: (context) {
        final routedWidget = _routersMap[settings.name!]?.to(
          context: context,
          route: settings.name!,
          args: settings.arguments,
        );

        if (routedWidget == null)
          throw Exception("Unable to handle the route: ${settings.name}");

        return routedWidget;
      },
    );
  }
}
