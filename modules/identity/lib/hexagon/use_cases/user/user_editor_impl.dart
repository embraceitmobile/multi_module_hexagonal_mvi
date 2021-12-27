import 'package:identity/hexagon/entities/user.dart';
import 'package:identity/hexagon/interfaces/user_repo.dart';
import 'package:identity/hexagon/use_cases/user/user_reader_impl.dart';
import 'package:identity/hexagon/use_cases/user/user_use_cases.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: UserEditor)
class UserEditorImpl extends UserReaderImpl implements UserEditor {
  final UserRepository _repository;

  const UserEditorImpl(this._repository) : super(_repository);

  Future<bool> removeUser(int userId) async {
    try {
      return await _repository.removeUser(userId);
    } on Exception {
      rethrow;
    }
  }

  Future<bool> updateUser(User user) async {
    try {
      return await _repository.updateUser(user);
    } on Exception {
      rethrow;
    }
  }
}
