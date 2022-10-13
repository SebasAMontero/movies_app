import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/core/util/service_constants.dart';
import 'package:movies_app/data/datasource/remote/api_service.dart';

import '../../mocks.dart';
import 'api_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late ApiService service;
  late MockClient client;

  setUp(() {
    client = MockClient();
    service = ApiService(client: client);
  });

  group('Api Service Class Unit Tests', () {
    test('Api Service call with endpoint', () async {
      when(
        client.get(
          Uri.parse(
            '${ServiceConstants.baseUrl}${ServiceConstants.endpoints['Top Rated']}',
          ),
          headers: ServiceConstants.headers,
        ),
      ).thenAnswer((_) async {
        return http.Response(
          jsonEncode(apiResponseJson),
          HttpStatus.ok,
        );
      });
      expect(
        await service.apiCall(
          endpoint: ServiceConstants.endpoints['Top Rated'],
        ),
        isA<http.Response>(),
      );
    });
    test('Api Service call with endpoint', () async {
      when(
        client.get(
          Uri.parse(
            '${ServiceConstants.baseUrl}${ServiceConstants.endpoints['Top Rated']}',
          ),
          headers: ServiceConstants.headers,
        ),
      ).thenAnswer((_) async {
        return http.Response(
          jsonEncode(apiResponseJson),
          HttpStatus.notFound,
        );
      });
      expect(
        await service.apiCall(
          endpoint: ServiceConstants.endpoints['Top Rated'],
        ),
        isA<http.Response>(),
      );
    });
  });
}
