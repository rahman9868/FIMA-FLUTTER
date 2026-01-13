import 'package:myapp/app/data/local/app_database.dart';
import 'package:myapp/app/data/models/attendance_summary_cache.dart';

import '../models/data_attendance_summary_dto.dart';
import '../providers/api_provider.dart';
import '../providers/cache_manager.dart';

class DashboardRepository {
  final ApiProvider _apiProvider = ApiProvider();
  final CacheManager _cacheManager = CacheManager();
  final AppDatabase _database;

  DashboardRepository(this._database);

  Future<(DataAttendanceSummaryDto?, DateTime?)> getAttendanceSummary() async {
    final cachedSummary = await _database.attendanceSummaryCacheDao
        .getLatestSummary();

    if (cachedSummary != null) {
      final cachedTime = DateTime.fromMillisecondsSinceEpoch(cachedSummary.timestamp);
      if (DateTime.now().difference(cachedTime).inMinutes < 5) {
        final summaryDto = dataAttendanceSummaryDtoFromJson(cachedSummary.summaryJson);
        return (summaryDto, cachedTime);
      }
    }
    return await _fetchAndCacheSummary();
  }

  Future<(DataAttendanceSummaryDto, DateTime)> _fetchAndCacheSummary() async {
    final user = await _cacheManager.getUserProfile();
    final now = DateTime.now();
    final summary = await _apiProvider.getEmployeeSummary(
      user!.id,
      now.year,
      now.month,
    );
    final summaryJson = dataAttendanceSummaryDtoToJson(summary);
    final updateTime = DateTime.now();
    final cache = AttendanceSummaryCache(
      id: 1,
      summaryJson: summaryJson,
      timestamp: updateTime.millisecondsSinceEpoch,
    );
    await _database.attendanceSummaryCacheDao.insertSummary(cache);
    await _cacheManager.saveLastUpdate();
    return (summary, updateTime);
  }

  Future<(DataAttendanceSummaryDto, DateTime)> refreshAttendanceSummary() async {
    return await _fetchAndCacheSummary();
  }
}
