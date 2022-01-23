import 'mock_local_data_source.dart';

class MockObject implements Dto {
  final String uniqueKey;
  final String value;

  MockObject({required this.uniqueKey, required this.value});

  factory MockObject.fromDtoMap(Map<String, dynamic> map) => MockObject(
        uniqueKey: map[Dto.unique_key],
        value: "value",
      );

  @override
  Map<String, dynamic> toDtoMap() =>
      {Dto.unique_key: uniqueKey, "value": value};
}
