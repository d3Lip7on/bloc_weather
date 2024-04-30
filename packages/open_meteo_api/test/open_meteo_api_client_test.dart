import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:open_meteo_api/open_meteo_api.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  group('OpenMeteoApiClient', () {
    late http.Client httpClient;
    late OpenMeteoApiClient apiClient;

    setUpAll(() {
      registerFallbackValue(FakeUri());
    });
    setUp(() {
      httpClient = MockHttpClient();
      apiClient = OpenMeteoApiClient(httpClient: httpClient);
    });
    group('constructor', () {
      test('does not require an httpClient', () {
        expect(OpenMeteoApiClient(), isNotNull);
      });
    });
    group('locationSearch', () {
      const query = 'mock-query';
      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await apiClient.locationSearch(query: query);
        } catch (_) {}
        verify(() => httpClient.get(
              Uri.https(
                'geocoding-api.open-meteo.com',
                '/v1/search',
                {'name': query, 'count': '1'},
              ),
            )).called(1);
      });
      test('throws LocationRequestFailure on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(() async => apiClient.locationSearch(query: query),
            throwsA(isA<LocationRequestFailure>()));
      });
      test('throws LocationNotFoundFailure on error response', () {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(apiClient.locationSearch(query: query),
            throwsA(isA<LocationNotFoundFailure>()));
      });
    });
  });
}
