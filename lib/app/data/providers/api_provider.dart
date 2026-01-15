import '../models/auth_tokens_model.dart';
import '../models/data_attendance_summary_dto.dart';
import '../models/employee_dto.dart';
import '../models/work_calendar_dto.dart';
import 'api_client.dart';
import 'cache_manager.dart';

class ApiProvider {
  final ApiClient _apiClient = ApiClient(
    "https://wf.dev.neo-fusion.com/fira-api/",
  );
  final CacheManager _cacheManager = CacheManager();

  final String encodedCredentials =
      "ZmlyYS1hcGktY2xpZW50OnBsZWFzZS1jaGFuZ2UtdGhpcw";

  Future<AuthTokens> login(String username, String password) async {
    final response = await _apiClient.post(
      "oauth/token",
      headers: {'Authorization': 'Basic $encodedCredentials'},
      body: {
        'username': username,
        'password': password,
        'grant_type': 'password',
      },
    );

    final tokens = AuthTokens.fromJson(response);
    await _cacheManager.saveAuthTokens(tokens);
    return tokens;
  }

  Future<EmployeeDto> getUserProfile() async {
    final tokens = await _cacheManager.getAuthTokens();
    final response = await _apiClient.get(
      "att/employee/acl",
      headers: {'Authorization': 'Bearer ${tokens?.accessToken}'},
    );
    final profile = EmployeeDto.fromJson(response);
    await _cacheManager.saveUserProfile(profile);
    return profile;
  }

  Future<DataAttendanceSummaryDto> getEmployeeSummary(
    int employeeId,
    int year,
    int month,
  ) async {
    final tokens = await _cacheManager.getAuthTokens();
    final response = await _apiClient.get(
      "att/attendanceSummary/$employeeId/$year/$month",
      headers: {'Authorization': 'Bearer ${tokens?.accessToken}'},
    );
    final summary = DataAttendanceSummaryDto.fromJson(response);
    return summary;
  }

  Future<WorkCalendarDto> getWorkCalendar(String employeeId, int year, int month) async {
    final tokens = await _cacheManager.getAuthTokens();
    final response = await _apiClient.get(
      "att/workCalendar/$employeeId/$year/$month",
      headers: {'Authorization': 'Bearer ${tokens?.accessToken}'},
    );
    return WorkCalendarDto.fromJson(response);
  }
}
