import 'package:core/core.dart';
import 'package:get_it/get_it.dart';
import 'package:identity/hexagon/interfaces/auth_repo.dart';
import 'package:identity/hexagon/use_cases/auth/auth_actions_impl.dart';
import 'package:identity/hexagon/use_cases/auth/auth_listener_impl.dart';
import 'package:identity/hexagon/use_cases/auth/auth_reader_impl.dart';
import 'package:identity/hexagon/use_cases/auth/auth_use_cases.dart';
import 'package:identity/hexagon/use_cases/user/user_editor_impl.dart';
import 'package:identity/hexagon/use_cases/user/user_listener_impl.dart';
import 'package:identity/hexagon/use_cases/user/user_reader_impl.dart';
import 'package:identity/identity.dart';
import 'package:injectable/injectable.dart';

GetIt configureIdentityHexagonInjection() {
  final gh = GetItHelper(getIt);

  gh.singleton<AuthReader>(AuthReaderImpl(getIt<AuthRepository>()));
  gh.singleton<AuthListener>(AuthListenerImpl(getIt<AuthRepository>()));
  gh.singleton<AuthActions>(AuthActionsImpl(
    getIt<AuthRepository>(),
    getIt<UserRepository>(),
  ));

  gh.singleton<UserReader>(UserReaderImpl(getIt<UserRepository>()));
  gh.singleton<UserEditor>(UserEditorImpl(getIt<UserRepository>()));
  gh.singleton<UserListener>(UserListenerImpl(getIt<UserRepository>()));

  return getIt;
}
