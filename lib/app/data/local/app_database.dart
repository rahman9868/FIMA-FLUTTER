import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../models/attendance_summary_cache.dart';
import 'dao/attendance_summary_cache_dao.dart';

part 'app_database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [AttendanceSummaryCache])
abstract class AppDatabase extends FloorDatabase {
  AttendanceSummaryCacheDao get attendanceSummaryCacheDao;
}
