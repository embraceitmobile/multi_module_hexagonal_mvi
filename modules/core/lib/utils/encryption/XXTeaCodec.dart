import 'dart:convert';

import 'XXTeaDecoder.dart';
import 'XXTeaEncoder.dart';

/// Simple encryption codec using xxtea
/// It requires a password to encrypt/decrypt the data
class XXTeaCodec extends Codec<Map<String, dynamic>, String> {
  XXTeaEncoder _encoder;
  XXTeaDecoder _decoder;

  /// A non null [password] to use for the encryption/decryption
  XXTeaCodec(String password)
      : _encoder = XXTeaEncoder(password),
        _decoder = XXTeaDecoder(password);

  @override
  Converter<String, Map<String, dynamic>> get decoder => _decoder;

  @override
  Converter<Map<String, dynamic>, String> get encoder => _encoder;
}
