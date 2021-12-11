import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:identity/identity.dart';
import 'package:identity/ui/screens/user_edit_profile/stores/user_profile_store.dart';
import 'package:identity/ui/shared_widgets/centered_progress_indicator.dart';
import 'package:mobx/mobx.dart';

import 'widgets/user_edit_profile_item_tile.dart';

class UserEditProfileScreen extends StatefulWidget {
  static const navigator = NamedNavigator<void>("/user_edit_profile");

  const UserEditProfileScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserEditProfileScreenState();
}

class _UserEditProfileScreenState extends State<UserEditProfileScreen> {
  late final UserEditProfileStore _userProfileStore =
      getIt<UserEditProfileStore>();
  late final List<ReactionDisposer> _disposers;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text("Edit Profile"),
          actions: [
            TextButton(
              onPressed: () => _userProfileStore.updateUserProfile(
                User(
                  id: 1,
                  username: "username",
                  email: "email",
                ),
              ),
              child: Text("Save"),
            ),
          ],
        ),
        body: Observer(
          builder: (context) => _userProfileStore.user.when(
              success: (user) => UserProfileForm(
                    user: user,
                    onNewImage: (newImage) =>
                        _userProfileStore.setNewImageUrl(newImage),
                  ),
              loading: (_) => CenteredProgressIndicator(),
              error: (error) => UserProfileErrorState(
                    errorMessage: error.toString(),
                  ),
              nothing: () => UserProfileEmptyState()),
        ),
      ),
    );
  }
}

class UserProfileForm extends StatefulWidget {
  final User user;
  final ValueSetter<String> onNewImage;

  const UserProfileForm(
      {Key? key, required this.user, required this.onNewImage})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserProfileFormState();
}

class _UserProfileFormState extends State<UserProfileForm> {
  late final TextEditingController _fullNameTec;
  late final TextEditingController _emailTec;
  late final TextEditingController _phoneTec;
  late final TextEditingController _websiteTec;
  late final TextEditingController _companyTec;

  @override
  void initState() {
    _fullNameTec = TextEditingController(text: widget.user.name);
    _emailTec = TextEditingController(text: widget.user.email);
    _phoneTec = TextEditingController(text: widget.user.phone);
    _websiteTec = TextEditingController(text: widget.user.website);
    _companyTec = TextEditingController(text: widget.user.company?.name);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: [
          UserEditProfileItemTile(label: "Full name", controller: _fullNameTec),
          UserEditProfileItemTile(label: "Email", controller: _emailTec),
          UserEditProfileItemTile(label: "Phone", controller: _phoneTec),
          UserEditProfileItemTile(label: "Website", controller: _websiteTec),
          UserEditProfileItemTile(label: "Company", controller: _companyTec),
        ],
      ),
    );
  }
}

class UserProfileErrorState extends StatelessWidget {
  final String errorMessage;

  const UserProfileErrorState({Key? key, required this.errorMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class UserProfileEmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
