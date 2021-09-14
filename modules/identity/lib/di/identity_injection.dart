import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import 'identity_injection.config.dart';

@injectableInit
Future<void> configureIdentityInjection() async {
  $initGetIt(getIt);
}
