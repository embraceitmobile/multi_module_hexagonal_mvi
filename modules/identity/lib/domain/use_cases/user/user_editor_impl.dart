import 'package:identity/domain/entities/user.dart';
import 'package:identity/domain/interfaces/user_repo.dart';
import 'package:identity/domain/use_cases/user/user_reader_impl.dart';
import 'package:identity/domain/use_cases/user/user_use_cases.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: UserEditor)
class UserEditorImpl extends UserReaderImpl implements UserEditor {
  final UserRepository _repository;

  const UserEditorImpl(this._repository) : super(_repository);

  Future<void> removeUser(int userId) async {
    try {
      await _repository.removeUser(userId);
    } on Exception {
      rethrow;
    }
  }

  Future<void> updateUser(User user) async {
    try {
      await _repository.updateUser(user);
    } on Exception {
      rethrow;
    }
  }
}
