import 'package:core/core.dart';
import 'package:get_it/get_it.dart';
import 'package:identity/presentation/screens/login/stores/login_form_store.dart';
import 'package:injectable/injectable.dart';

GetIt configureIdentityUiInjection() {
  final gh = GetItHelper(getIt);

  gh.lazySingleton<LoginFormStore>(() => LoginFormStore());

  return getIt;
}
