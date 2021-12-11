import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:identity/identity.dart';

class UserProfileScreen extends StatelessWidget {
  static const navigator = NamedNavigator<void>("/user_profile");

  const UserProfileScreen({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return StreamBuilder<DataState<User>>(
        stream: getIt<UserListener>().observeActiveUser(),
        initialData: DataState.nothing(),
        builder: (context, snapshot) => snapshot.requireData.when(
            success: (user) => _UserProfileSuccess(user: user),
            loading: (progress) => _UserProfileLoading(),
            error: (error) => _UserProfileError(error: error),
            nothing: () => _UserProfileNothing()));
  }
}

class _UserProfileSuccess extends StatelessWidget {
  final User user;

  const _UserProfileSuccess({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class _UserProfileError extends StatelessWidget {
  final Exception error;

  const _UserProfileError({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class _UserProfileLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class _UserProfileNothing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
