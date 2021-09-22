import 'package:core/core.dart';
import 'package:identity/hexagon/entities/auth_state.dart';
import 'package:identity/hexagon/use_cases/auth/auth_use_cases.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

@lazySingleton
abstract class _LoginStore with Store {
  static const TAG = "LoginStore";

  final AuthListener _authListener;
  final AuthActions _authActions;

  @factoryMethod
  _LoginStore(this._authListener, this._authActions);

  @observable
  late ObservableStream<DataState<AuthState>> _authState =
      ObservableStream(_authListener.observeAuthState());

  @computed
  DataState<AuthState> get authState =>
      _authState.value ?? DataState.nullOrEmpty();

  @action
  Future<bool?> login({required String email, required String password}) async {
    try {
      return _authActions.login(email: email, password: password);
    } on Exception catch (e) {
      print("[$TAG][login] error: $e");
    }
  }
}
