import 'package:core/core.dart';
import 'package:get_it/get_it.dart';
import 'package:identity/domain/use_cases/auth/implementations/auth_actions_impl.dart';
import 'package:identity/domain/use_cases/auth/implementations/auth_listener_impl.dart';
import 'package:identity/domain/use_cases/auth/implementations/auth_reader_impl.dart';
import 'package:identity/domain/use_cases/user/implementations/user_editor_impl.dart';
import 'package:identity/domain/use_cases/user/implementations/user_listener_impl.dart';
import 'package:identity/domain/use_cases/user/implementations/user_reader_impl.dart';
import 'package:identity/identity.dart';
import 'package:injectable/injectable.dart';

GetIt configureIdentityDomainInjection() {
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
