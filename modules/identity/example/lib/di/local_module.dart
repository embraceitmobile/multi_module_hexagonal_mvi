import 'dart:async';

import 'package:core/core.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';

@module
abstract class LocalModule {
  @singleton
  @preResolve
  Future<ILocalDbClient> provideLocalDbClient() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    return await SembastDbClient.constructAsync(appDocumentDir.path);
  }
}
