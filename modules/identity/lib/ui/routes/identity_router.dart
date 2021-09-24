import 'package:core/core.dart';
import 'package:identity/ui/screens/login/login_screen.dart';
import 'package:identity/ui/screens/profile/profile_screen.dart';

class IdentityRouter with IRouter {
  static const _loginScreen = "login/";
  static const _profileScreen = "profile/";

  final Map<String, RouteBuilder> routes = {
    _loginScreen: (context, args) => LoginScreen(),
    _profileScreen: (context, args) => ProfileScreen(),
  };
}
