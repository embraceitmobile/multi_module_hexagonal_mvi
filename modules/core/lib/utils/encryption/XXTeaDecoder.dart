import 'dart:convert';

import 'package:xxtea/xxtea.dart';

class XXTeaDecoder extends Converter<String, Map<String, dynamic>> {
  final String key;

  XXTeaDecoder(this.key);

  @override
  Map<String, dynamic> convert(String input) {
    final decryptedString = xxtea.decryptToString(input, key);
    if (decryptedString != null) {
      var result = json.decode(decryptedString);
      if (result is Map) {
        return result.cast<String, dynamic>();
      }
    }
    throw FormatException('invalid input $input');
  }
}
