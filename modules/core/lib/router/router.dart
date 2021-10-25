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

/// A helper class for Named Navigation using route names. Each navigable screen
/// should contain a static [NamedNavigator] implementation that specifies the
/// type [T] of the args that the screen accepts.
class NamedNavigator<T extends Object?> {
  final String route;

  const NamedNavigator(this.route);

  Future<T?> push(BuildContext context, {T? args}) {
    return Navigator.of(context).pushNamed(route, arguments: args);
  }

  Future<T?> pushReplacement(BuildContext context, {T? args}) {
    return Navigator.of(context).pushReplacementNamed(route, arguments: args);
  }

  Future<T?> popAndPush(BuildContext context, {T? args}) {
    return Navigator.of(context).popAndPushNamed(route, arguments: args);
  }

  Future<T?> pushAndRemoveUntil(BuildContext context, RoutePredicate predicate,
      {T? args}) {
    return Navigator.of(context)
        .pushNamedAndRemoveUntil(route, predicate, arguments: args);
  }
}

/// Class to aggregate the routes from different modules and handle the routes
/// from a single source.
class RouteHandler {
  /// Add all the [IRouter]s from different modules here.
  final List<IRouter> routers;

  /// The screen to be returned on "/" root path.
  final Widget root;

  /// The screen to be returned when the route cannot be matched in the provided
  /// [routers]
  final Widget onPageNotFound;

  /// The index of all the routes that are recognized by the passed [routers].
  final Map<String, IRouter> _routersMap;

  String get defaultRoute => RootRouter.rootRoute;

  RouteHandler(
    this.routers, {
    this.root = const RootPage(),
    this.onPageNotFound = const PageNotFound(),
  }) : _routersMap = _indexAllRoutes([RootRouter(root), ...routers]);

  static Map<String, IRouter> _indexAllRoutes(List<IRouter> routers) {
    final Map<String, IRouter> routersMap = {};

    for (final router in routers) {
      for (final route in router.routes.keys) {
        routersMap.putIfAbsent(route, () => router);
      }
    }
    return routersMap;
  }

  /// Pass this method to the [onGenerateRoute] method of [MaterialApp] to
  /// handle the routes dynamically.
  Route onGenerateRoute(RouteSettings settings) {
    if (settings.name == null) throw Exception('Route name not provided');

    return MaterialPageRoute(
      settings: settings,
      builder: (context) {
        final page = _routersMap[settings.name!]?.buildRoute(
          context: context,
          route: settings.name!,
          args: settings.arguments,
        );

        if (page == null)
          print(
              "Unable to handle the route: ${settings.name}, returning default route");

        return page ?? onPageNotFound;
      },
    );
  }
}

class PageNotFound extends StatelessWidget {
  const PageNotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Text("404\nPage Not Found"),
      ),
    );
  }
}

class RootPage extends StatelessWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container();
}

class RootRouter with IRouter {
  final Widget rootPage;

  static const rootRoute = "/";

  final Map<String, RouteBuilder> routes;

  RootRouter(this.rootPage)
      : this.routes = {rootRoute: (context, args) => rootPage};
}
