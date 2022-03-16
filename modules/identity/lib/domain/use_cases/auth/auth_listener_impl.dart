import 'package:core/core.dart';
import 'package:identity/domain/entities/auth_state.dart';
import 'package:identity/domain/interfaces/auth_repo.dart';
import 'package:identity/domain/use_cases/auth/auth_use_cases.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: AuthListener)
class AuthListenerImpl implements AuthListener {
  final AuthRepository _repository;

  const AuthListenerImpl(this._repository);

  Stream<Resource<AuthState>> observeAuthState() =>
      _repository.observeAuthInfo().map(
            (authInfoState) => authInfoState.when(
              success: (authInfo) => Resource.success(AuthState.Authenticated),
              nothing: () => Resource.success(AuthState.Unauthenticated),
              loading: (progress) => Resource.loading(),
              error: (exception) => Resource.error(exception),
            ),
          );
}
