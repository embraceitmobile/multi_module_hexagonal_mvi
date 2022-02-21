import 'dart:convert';

import 'package:xxtea/xxtea.dart';

class XXTeaEncoder extends Converter<Map<String, dynamic>, String> {
  final String key;

  XXTeaEncoder(this.key);

  @override
  String convert(Map<String, dynamic> input) =>
      xxtea.encryptToString(json.encode(input), key) ?? "";
}
