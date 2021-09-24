import 'package:core/core.dart';
import 'package:identity/ui/screens/login/login_screen.dart';
import 'package:identity/ui/screens/profile/profile_screen.dart';

class IdentityRouter with IRouter {
  final Map<String, RouteBuilder> routes = {
    LoginScreen.navigator.route: (context, args) => const LoginScreen(),
    ProfileScreen.navigator.route: (context, args) => const ProfileScreen(),
  };
}
