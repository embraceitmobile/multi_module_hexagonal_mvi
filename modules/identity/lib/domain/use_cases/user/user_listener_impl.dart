import 'package:core/models/data_state/data_state.dart';
import 'package:identity/domain/entities/user.dart';
import 'package:identity/domain/interfaces/user_repo.dart';
import 'package:identity/domain/use_cases/user/user_use_cases.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: UserListener)
class UserListenerImpl implements UserListener {
  final UserRepository _repository;

  const UserListenerImpl(this._repository);

  Stream<DataState<User>> observeUser() {
    return _repository.observeActiveUser();
  }
}
