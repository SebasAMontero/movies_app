import 'package:http/http.dart' as http;
import '../../../core/util/service_constants.dart';

class ApiService {
  final http.Client _client;

  ApiService({
    http.Client? client,
  }) : _client = client ?? http.Client();

  Future<http.Response> apiCall({endpoint}) async {
    Uri uri;
    uri = Uri.parse('${ServiceConstants.baseUrl}$endpoint');
    var response = await _client.get(
      uri,
      headers: ServiceConstants.headers,
    );
    return response;
  }
}
