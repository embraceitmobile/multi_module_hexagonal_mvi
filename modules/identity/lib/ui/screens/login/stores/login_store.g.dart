// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginStore on _LoginStore, Store {
  Computed<DataState<AuthInfo>>? _$authStateComputed;

  @override
  DataState<AuthInfo> get authInfo => (_$authStateComputed ??=
          Computed<DataState<AuthInfo>>(() => super.authInfo,
              name: '_LoginStore.authState'))
      .value;

  final _$_authStateAtom = Atom(name: '_LoginStore._authState');

  @override
  ObservableStream<DataState<AuthInfo>> get _authInfo {
    _$_authStateAtom.reportRead();
    return super._authInfo;
  }

  @override
  set _authInfo(ObservableStream<DataState<AuthInfo>> value) {
    _$_authStateAtom.reportWrite(value, super._authInfo, () {
      super._authInfo = value;
    });
  }

  final _$loginAsyncAction = AsyncAction('_LoginStore.login');

  @override
  Future<bool?> login(String email, String password) {
    return _$loginAsyncAction.run(() => super.login(email, password));
  }

  @override
  String toString() {
    return '''
authState: ${authInfo}
    ''';
  }
}
