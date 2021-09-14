import 'package:identity/hexagon/entities/auth_info.dart';
import 'package:identity/hexagon/interfaces/auth_repo.dart';
import 'package:identity/hexagon/use_cases/auth/auth_use_cases.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: AuthReader)
class AuthReaderImpl implements AuthReader {
  final AuthRepository _repository;

  const AuthReaderImpl(this._repository);

  Future<bool> get isAuthenticated async {
    try {
      return await _repository.isAuthenticated;
    } on Exception {
      rethrow;
    }
  }

  Future<AuthInfo?> get authInfo async {
    try {
      return await _repository.authInfo;
    } on Exception {
      rethrow;
    }
  }
}
