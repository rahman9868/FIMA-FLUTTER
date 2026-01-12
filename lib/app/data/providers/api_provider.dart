import '../models/auth_tokens_model.dart';
import 'api_client.dart';

class ApiProvider {
  final ApiClient _apiClient = ApiClient(
    "https://wf.dev.neo-fusion.com/fira-api/",
  );

  final String encodedCredentials =
      "ZmlyYS1hcGktY2xpZW50OnBsZWFzZS1jaGFuZ2UtdGhpcw";

  Future<AuthenticationTokens> login(String username, String password) async {
    final response = await _apiClient.post(
      "oauth/token",
      headers: {'Authorization': 'Basic $encodedCredentials'},
      body: {
        'username': username,
        'password': password,
        'grant_type': 'password',
      },
    );

    return AuthenticationTokens.fromJson(response);
  }
}
