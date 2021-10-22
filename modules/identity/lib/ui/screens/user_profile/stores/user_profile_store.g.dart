// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserProfileStore on _UserProfileStore, Store {
  Computed<DataState<User>>? _$userComputed;

  @override
  DataState<User> get user =>
      (_$userComputed ??= Computed<DataState<User>>(() => super.user,
              name: '_UserProfileStore.user'))
          .value;

  final _$_userStateAtom = Atom(name: '_UserProfileStore._userState');

  @override
  ObservableStream<DataState<User>> get _userState {
    _$_userStateAtom.reportRead();
    return super._userState;
  }

  @override
  set _userState(ObservableStream<DataState<User>> value) {
    _$_userStateAtom.reportWrite(value, super._userState, () {
      super._userState = value;
    });
  }

  final _$updateUserProfileAsyncAction =
      AsyncAction('_UserProfileStore.updateUserProfile');

  @override
  Future<bool?> updateUserProfile(User user) {
    return _$updateUserProfileAsyncAction
        .run(() => super.updateUserProfile(user));
  }

  @override
  String toString() {
    return '''
user: ${user}
    ''';
  }
}
