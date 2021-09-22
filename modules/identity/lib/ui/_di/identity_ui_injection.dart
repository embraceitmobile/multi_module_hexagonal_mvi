import 'package:core/core.dart';
import 'package:get_it/get_it.dart';
import 'package:identity/hexagon/use_cases/auth/auth_use_cases.dart';
import 'package:identity/ui/screens/login/stores/login_form_store.dart';
import 'package:identity/ui/screens/login/stores/login_store.dart';
import 'package:injectable/injectable.dart';

GetIt configureIdentityUiInjection() {
  final gh = GetItHelper(getIt);

  gh.lazySingleton<LoginFormStore>(() => LoginFormStore());
  gh.lazySingleton<LoginStore>(
      () => LoginStore(getIt<AuthListener>(), getIt<AuthActions>()));

  return getIt;
}
