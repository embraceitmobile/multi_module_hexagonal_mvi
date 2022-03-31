import 'package:core/datasources/local/local_dto.dart';

typedef Mapper<T> = T Function(Map<String, dynamic>);

abstract class SembastDto<K> extends LocalDto<K> {
  K get id;

  external factory SembastDto.fromDtoMap(Map<String, dynamic> map);

  /// DbMap should not contain any sub-lists
  Map<String, dynamic> toDtoMap();
}
