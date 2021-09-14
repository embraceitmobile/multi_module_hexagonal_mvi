import 'package:identity/hexagon/entities/user.dart';
import 'package:identity/hexagon/interfaces/user_repo.dart';
import 'package:identity/hexagon/use_cases/user/user_use_cases.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: UserReader)
class UserReaderImpl implements UserReader {
  final UserRepository _repository;

  const UserReaderImpl(this._repository);

  Future<User?> get activeUser async {
    try {
      return await _repository.activeUser;
    } on Exception {
      rethrow;
    }
  }

  Future<User?> getUserById(int id) async {
    try {
      return await _repository.getUserById(id);
    } on Exception {
      rethrow;
    }
  }

  Future<List<User>> get users async {
    try {
      return await _repository.users;
    } on Exception {
      rethrow;
    }
  }
}
