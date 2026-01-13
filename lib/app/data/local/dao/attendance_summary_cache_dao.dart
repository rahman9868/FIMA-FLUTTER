import 'package:floor/floor.dart';
import 'package:myapp/app/data/models/attendance_summary_cache.dart';

@dao
abstract class AttendanceSummaryCacheDao {
  @Query(
    'SELECT * FROM attendance_summary_cache ORDER BY timestamp DESC LIMIT 1',
  )
  Future<AttendanceSummaryCache?> getLatestSummary();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertSummary(AttendanceSummaryCache summary);

  @Query('DELETE FROM attendance_summary_cache')
  Future<void> clearCache();
}
