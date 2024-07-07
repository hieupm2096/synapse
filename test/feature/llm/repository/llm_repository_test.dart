// SimpleTest

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:synapse/app/data_source/kvp_lds/kvp_lds.dart';
import 'package:synapse/feature/llm/data_source/llm_lds/llm_lds.dart';
import 'package:synapse/feature/llm/repository/llm_repository.dart';

class MockLlmLDS extends Mock implements ILlmLDS {}

class MockJsonLlmLDS extends Mock implements ILlmLDS {}

class MockKVPLocalDS extends Mock implements IKVPLocalDS {}

void main() {
  late final ILlmLDS llmLDS;
  late final ILlmLDS jsonLlmLDS;
  late final IKVPLocalDS kvpLDS;
  late final LlmRepository repository;

  setUp(() {
    llmLDS = MockLlmLDS();
    jsonLlmLDS = MockJsonLlmLDS();
    kvpLDS = MockKVPLocalDS();
    repository = LlmRepository(
      llmLDS: llmLDS,
      jsonLlmLDS: jsonLlmLDS,
      kvpLDS: kvpLDS,
    );
  });

  group('getLlmModels', () {
    test('verify ILlmLDS.getLlmModels called 1 time', () async {
      // arrange
      when(() => llmLDS.getLlmModels()).thenAnswer((_) async => []);
      when(() => jsonLlmLDS.getLlmModels()).thenAnswer((_) async => []);
      when(() => llmLDS.createLlmModels(data: any(named: 'data')))
          .thenAnswer((_) async {});

      // act
      await repository.getLlmModels();

      // assert
      expect(llmLDS, isA<MockLlmLDS>());
      verify(() => llmLDS.getLlmModels()).called(1);
    });
  });
}
