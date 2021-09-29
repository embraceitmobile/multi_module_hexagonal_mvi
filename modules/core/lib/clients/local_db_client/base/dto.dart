abstract class Dto {
  static const unique_key = 'unique_key';

  /// DbMap should not contain any sub-lists
  Map<String, dynamic> toDtoMap();

  external factory Dto.fromDtoMap(Map<String, dynamic> map);

  String get uniqueKey;
}

abstract class StateDto implements Dto {
  LocalState get state;
}

enum LocalState { loading, success, failed }

extension StateExt on LocalState {
  int get toInt {
    switch (this) {
      case LocalState.loading:
        return 0;
      case LocalState.success:
        return 1;
      case LocalState.failed:
        return 2;
    }
  }
}

extension IntExt on num {
  LocalState get toState {
    switch (this) {
      case 0:
        return LocalState.loading;
      case 1:
        return LocalState.success;
      case 2:
        return LocalState.failed;
      default:
        return LocalState.success;
    }
  }
}
