import 'dart:async';

import 'package:cubivue_utils/basic_utils.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

import 'base/i_local_db_client.dart';

class SembastDbClient implements ILocalDbClient {
  final Database database;

  SembastDbClient(this.database);

  static Future<SembastDbClient> constructAsync() async {
    {
      // Key for encryption
      var encryptionKey = "";

      // Get a platform-specific directory where persistent app data can be stored
      final appDocumentDir = await getApplicationDocumentsDirectory();

      // Path with the form: /platform-specific-directory/demo.db
      final dbPath = join(appDocumentDir.path, ILocalDbClient.DB_NAME);

      // Check to see if encryption is set, then provide codec
      // else init normal db with path
      var database;
      if (encryptionKey.isNotEmpty) {
        // Initialize the encryption codec with a user password
        var codec = EncryptionUtils.getXXTeaCodec(password: encryptionKey);
        database = await databaseFactoryIo.openDatabase(dbPath, codec: codec);
      } else {
        database = await databaseFactoryIo.openDatabase(dbPath);
      }

      // Return database instance
      return SembastDbClient(database);
    }
  }
}
