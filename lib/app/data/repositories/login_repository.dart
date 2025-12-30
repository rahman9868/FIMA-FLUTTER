import '../providers/api_provider.dart';
import '../models/auth_tokens_model.dart';

class LoginRepository {
  final ApiProvider _apiProvider = ApiProvider();

  Future<AuthenticationTokens?> login(String username, String password) {
    return _apiProvider.login(username, password);
  }
}
