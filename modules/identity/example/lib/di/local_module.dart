import 'dart:async';

import 'package:core/clients/local_db_clients/sembast/sembast_db_client.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

@module
abstract class LocalModule {
  @singleton
  @preResolve
  Future<ILocalDbClient> provideLocalDbClient() async =>
      await SembastDbClient.constructAsync();
}
