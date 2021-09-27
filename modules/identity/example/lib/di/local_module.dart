import 'dart:async';

import 'package:core/clients/local_db_client/sembast_client.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

@module
abstract class LocalModule {
  @singleton
  @preResolve
  Future<ILocalDbClient> provideLocalDbClient() async =>
      await SembastDbClient.constructAsync();
}
