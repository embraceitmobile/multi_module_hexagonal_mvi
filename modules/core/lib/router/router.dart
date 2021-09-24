import 'package:flutter/material.dart';

typedef RouteBuilder = Widget Function(BuildContext context, Object? args);

mixin IRouter {
  /// Register all the routes here. The [key] will be used to match the route
  /// and the matching route will be passed on to the [RouteBuilder].
  Map<String, RouteBuilder> get routes;

  /// Builds the [route] that matches path in the [routes]. If no matching [route]
  /// is found then a null is returned. If [args] are provided, they will be passed
  /// on to the routed [widget].
  ///
  /// Override this method to create your own custom route builder.
  Widget? buildRoute(
      {required BuildContext context, required String route, Object? args}) {
    return routes[route]?.call(context, args);
  }
}

/// Class to aggregate the routes from different modules and handle the routes
/// from a single source.
class RouteHandler {
  /// Add all the [IRouter]s from different modules here.
  final List<IRouter> routers;

  /// The index of all the routes that are recognized by the passed [routers].
  late final Map<String, IRouter> _routersMap;

  RouteHandler(this.routers) {
    for (final router in routers) {
      for (final route in router.routes.keys) {
        _routersMap.putIfAbsent(route, () => router);
      }
    }
  }

  /// Pass this method to the [onGenerateRoute] method of [MaterialApp] to
  /// handle the routes dynamically.
  Route onGenerateRoute(RouteSettings settings) {
    if (settings.name == null) throw Exception('Route name not provided');

    return MaterialPageRoute(
      settings: settings,
      builder: (context) {
        final routedWidget = _routersMap[settings.name!]?.buildRoute(
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
