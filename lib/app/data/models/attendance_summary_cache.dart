import 'package:floor/floor.dart';

@Entity(tableName: 'attendance_summary_cache')
class AttendanceSummaryCache {
  @primaryKey
  final int id;

  final String summaryJson;

  final int timestamp;

  AttendanceSummaryCache({
    required this.id,
    required this.summaryJson,
    required this.timestamp,
  });
}
