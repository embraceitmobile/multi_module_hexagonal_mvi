import 'package:core/core.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

GetIt configureIdentityUiInjection() {
  final gh = GetItHelper(getIt);

  return getIt;
}
