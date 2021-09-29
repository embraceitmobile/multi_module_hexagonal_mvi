import 'package:core/core.dart';
import 'package:identity/hexagon/entities/auth_state.dart';
import 'package:identity/hexagon/interfaces/auth_repo.dart';
import 'package:identity/hexagon/use_cases/auth/auth_use_cases.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: AuthListener)
class AuthListenerImpl implements AuthListener {
  final AuthRepository _repository;

  const AuthListenerImpl(this._repository);

  Stream<DataState<AuthState>> observeAuthState() =>
      _repository.observeAuthInfo().map(
            (authInfoState) => authInfoState.when(
              success: (authInfo) => DataState.success(AuthState.Authenticated),
              nullOrEmpty: () => DataState.success(AuthState.Unauthenticated),
              loading: () => DataState.loading(),
              error: (error) => DataState.error(error),
            ),
          );
}
