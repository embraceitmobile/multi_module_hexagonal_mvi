import 'package:core/core.dart';
import 'package:identity/identity.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'user_profile_store.g.dart';

class UserEditProfileStore = _UserEditProfileStore with _$UserEditProfileStore;

@lazySingleton
abstract class _UserEditProfileStore with Store {
  static const TAG = "UserProfileStore";

  final UserEditor _userEditor;
  final UserListener _userListener;

  @factoryMethod
  _UserEditProfileStore(this._userListener, this._userEditor);

  @observable
  late ObservableStream<DataState<User>> _userState =
      ObservableStream(_userListener.observeUser());

  @observable
  String? _newImageUrl;

  @computed
  DataState<User> get user =>
      (_userState.value ?? DataState.nothing()).transformOnly(
        success: (user) {
          if (_newImageUrl != null)
            user = user.copyWith(imageUrl: _newImageUrl);
          return DataState.success(user);
        },
      );

  @action
  void setNewImageUrl(String newImageUrl) {
    _newImageUrl = newImageUrl;
  }

  @action
  Future<bool?> updateUserProfile(User user) async {
    try {
      return await _userEditor.updateUser(user);
    } on Exception catch (e) {
      print("[$TAG][updateUserProfile] error: $e");
    }
  }

  void dispose() {
    getIt.resetLazySingleton<UserEditProfileStore>(instance: this);
  }
}
