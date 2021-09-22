import 'package:core/core.dart';
import 'package:get_it/get_it.dart';
import 'package:identity/hexagon/_di/identity_hexagon_injection.dart';
import 'package:identity/repository/_di/identity_repository_injection.dart';
import 'package:identity/ui/_di/identity_ui_injection.dart';
import 'package:injectable/injectable.dart';

///uncomment this for using [Injectable] code gen
// @injectableInit
// Future<void> configureIdentityInjection() async {
//   $initGetIt(getIt);
// }

/// use manual dependency if [Injectable] does not generate the dependencies in
/// the correct order.
GetIt configureIdentityInjection() {
  final gh = GetItHelper(getIt);

  configureIdentityRepositoryInjection();
  configureIdentityHexagonInjection();
  configureIdentityUiInjection();

  return getIt;
}
