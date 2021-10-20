import 'package:core/core.dart';
import 'package:identity/identity.dart';
import 'package:identity/ui/routes/identity_router.dart';
import 'package:identity/ui/screens/profile/profile_screen.dart';
import 'package:injectable/injectable.dart';

@module
abstract class RouteModule {
  RouteModule();

  @singleton
  IdentityRouter get identityRouter => IdentityRouter(
        onLoginEvent: (context, {args}) =>
            ProfileScreen.navigator.pushReplacement(context, args: args),
      );

  @singleton
  RouteHandler provideRouteHandler(IdentityRouter identityRouter) =>
      RouteHandler([identityRouter], root: RootScreen());
}
