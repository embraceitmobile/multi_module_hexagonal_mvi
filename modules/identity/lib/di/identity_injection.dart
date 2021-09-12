import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import 'injection.config.dart';

@injectableInit
Future<void> configureIdentityInjection() async {
  await $initGetIt(getIt);
}
