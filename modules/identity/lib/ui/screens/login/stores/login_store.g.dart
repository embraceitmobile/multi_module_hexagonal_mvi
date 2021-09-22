// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginStore on _LoginStore, Store {
  Computed<DataState<AuthState>>? _$authStateComputed;

  @override
  DataState<AuthState> get authState => (_$authStateComputed ??=
          Computed<DataState<AuthState>>(() => super.authState,
              name: '_LoginStore.authState'))
      .value;

  final _$_authStateAtom = Atom(name: '_LoginStore._authState');

  @override
  ObservableStream<DataState<AuthState>> get _authState {
    _$_authStateAtom.reportRead();
    return super._authState;
  }

  @override
  set _authState(ObservableStream<DataState<AuthState>> value) {
    _$_authStateAtom.reportWrite(value, super._authState, () {
      super._authState = value;
    });
  }

  final _$loginAsyncAction = AsyncAction('_LoginStore.login');

  @override
  Future<bool?> login({required String email, required String password}) {
    return _$loginAsyncAction
        .run(() => super.login(email: email, password: password));
  }

  @override
  String toString() {
    return '''
authState: ${authState}
    ''';
  }
}
