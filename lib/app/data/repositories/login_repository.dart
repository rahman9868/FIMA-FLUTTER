import '../providers/api_provider.dart';

class LoginRepository {
  final ApiProvider _apiProvider = ApiProvider();

  Future<void> login(String username, String password) async {
    await _apiProvider.login(username, password);
    await _apiProvider.getUserProfile();
  }
}
