import 'dart:async';
import 'package:core/datasources/local/i_local_db_client.dart';
import 'package:core/utils/encryption/XXTeaCodec.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';


const DB_NAME = 'sample.db';

class SembastDbClient implements ILocalDbClient {
  final Database database;

  SembastDbClient._(this.database);

  /// [path] is a platform-specific directory where persistent app data can be stored
  static Future<SembastDbClient> constructAsync(String path) async {
    {
      // Key for encryption
      var encryptionKey = "";

      // Path with the form: /platform-specific-directory/demo.db
      final dbPath = join(path, DB_NAME);

      // Check to see if encryption is set, then provide codec
      // else init normal db with path
      var database;
      if (encryptionKey.isNotEmpty) {
        // Initialize the encryption codec with a user password
        var codec =
            SembastCodec(signature: 'xxtea', codec: XXTeaCodec(encryptionKey));
        database = await databaseFactoryIo.openDatabase(dbPath, codec: codec);
      } else {
        database = await databaseFactoryIo.openDatabase(dbPath);
      }

      // Return database instance
      return SembastDbClient._(database);
    }
  }
}
