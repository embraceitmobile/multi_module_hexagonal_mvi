import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:identity/identity.dart';

export 'states/user_profile_error.dart';
export 'states/user_profile_loading.dart';
export 'states/user_profile_nothing.dart';
export 'states/user_profile_success.dart';

class UserProfileScreen extends StatelessWidget {
  static const navigator = NamedNavigator<void>("/user_profile");

  const UserProfileScreen({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Material(
      child: StreamBuilder<Resource<User>>(
        stream: getIt<UserListener>().observeUser(),
        initialData: Resource.loading(),
        builder: (context, snapshot) => AnimatedSwitcher(
          duration: Duration(milliseconds: 500),
          child: snapshot.requireData.when(
            success: (user) => UserProfileSuccess(user: user),
            loading: (progress) => UserProfileLoading(),
            error: (error) => UserProfileError(error: error),
            nothing: () => UserProfileNothing(),
          ),
        ),
      ),
    );
  }
}
