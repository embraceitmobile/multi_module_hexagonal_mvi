import 'package:identity/domain/entities/user.dart';
import 'package:identity/domain/interfaces/user_repo.dart';
import 'package:identity/domain/use_cases/user/user_use_cases.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: UserReader)
class UserReaderImpl implements UserReader {
  final UserRepository _repository;

  const UserReaderImpl(this._repository);

  @override
  Future<User?> get user async {
    try {
      return await _repository.user;
    } on Exception {
      rethrow;
    }
  }
}
