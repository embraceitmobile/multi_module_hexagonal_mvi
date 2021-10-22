import 'package:core/core.dart';
import 'package:identity/hexagon/use_cases/user/user_use_cases.dart';
import 'package:identity/identity.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'user_profile_store.g.dart';

class UserProfileStore = _UserProfileStore with _$UserProfileStore;

@lazySingleton
abstract class _UserProfileStore with Store {
  static const TAG = "ProfileStore";

  final UserEditor _userEditor;
  final UserListener _userListener;

  @factoryMethod
  _UserProfileStore(this._userListener, this._userEditor);

  @observable
  late ObservableStream<DataState<User>> _userState =
      ObservableStream(_userListener.observeActiveUser());

  @observable
  String? _newImageUrl;

  @computed
  DataState<User> get user =>
      (_userState.value ?? DataState.idleOrNoData()).map(
        success: (data) {
          var user = data as User;
          if (_newImageUrl != null)
            user = user.copyWith(imageUrl: _newImageUrl);
          return DataState.success(user);
        },
        loading: (progress) => DataState.loading(progress: progress as int),
        error: (error) => DataState.error(error as Exception),
        idleOrNoData: (_) => DataState.idleOrNoData(),
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
    getIt.resetLazySingleton<UserProfileStore>(instance: this);
  }
}
