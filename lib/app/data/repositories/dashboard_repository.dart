import 'dart:convert';

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

  Future<DataAttendanceSummaryDto?> getAttendanceSummary() async {
    final cachedSummary = await _database.attendanceSummaryCacheDao
        .getLatestSummary();

    if (cachedSummary != null &&
        DateTime.now()
                .difference(
                  DateTime.fromMillisecondsSinceEpoch(cachedSummary.timestamp),
                )
                .inMinutes <
            5) {
      return dataAttendanceSummaryDtoFromJson(cachedSummary.summaryJson);
    }
    return await _fetchAndCacheSummary();
  }

  Future<DataAttendanceSummaryDto> _fetchAndCacheSummary() async {
    final user = await _cacheManager.getUserProfile();
    final now = DateTime.now();
    final summary = await _apiProvider.getEmployeeSummary(
      user!.id,
      now.year,
      now.month,
    );
    final summaryJson = dataAttendanceSummaryDtoToJson(summary);
    final cache = AttendanceSummaryCache(
      id: 1, // Since we only cache one summary, the id can be constant
      summaryJson: summaryJson,
      timestamp: DateTime.now().millisecondsSinceEpoch,
    );
    await _database.attendanceSummaryCacheDao.insertSummary(cache);
    await _cacheManager.saveLastUpdate();
    return summary;
  }

  Future<DataAttendanceSummaryDto> refreshAttendanceSummary() async {
    return await _fetchAndCacheSummary();
  }
}
