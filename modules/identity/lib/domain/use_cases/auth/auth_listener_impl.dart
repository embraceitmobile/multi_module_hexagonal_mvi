import 'package:core/core.dart';
import 'package:identity/domain/entities/auth_state.dart';
import 'package:identity/domain/interfaces/auth_repo.dart';
import 'package:identity/domain/use_cases/auth/auth_use_cases.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: AuthListener)
class AuthListenerImpl implements AuthListener {
  final AuthRepository _repository;

  const AuthListenerImpl(this._repository);

  Stream<DataState<AuthState>> observeAuthState() =>
      _repository.observeAuthInfo().map(
            (authInfoState) => authInfoState.when(
              success: (authInfo) => DataState.success(AuthState.Authenticated),
              nothing: () => DataState.success(AuthState.Unauthenticated),
              loading: (progress) => DataState.loading(),
              error: (exception) => DataState.error(exception),
            ),
          );
}