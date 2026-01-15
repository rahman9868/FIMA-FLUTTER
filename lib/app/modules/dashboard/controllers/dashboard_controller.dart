import 'package:get/get.dart';
import 'package:myapp/app/data/models/data_attendance_summary_dto.dart';
import 'package:myapp/app/data/repositories/dashboard_repository.dart';

import '../../../data/providers/cache_manager.dart';

class DashboardController extends GetxController {
  final DashboardRepository repository;
  final CacheManager cacheManager;

  DashboardController({required this.repository, required this.cacheManager});

  final Rx<DataAttendanceSummaryDto?> attendanceSummary = Rx(null);
  final Rx<DateTime?> lastUpdate = Rx(null);
  final RxBool isLoading = false.obs;

  @override
  void onReady() {
    super.onReady();
    getAttendanceSummary();
  }

  Future<void> refreshSummary() async {
    getAttendanceSummary();
  }

  Map<String, int> get eventCounts {
    final counts = <String, int>{};
    final events = attendanceSummary.value?.data?.first.event;
    if (events != null) {
      for (final event in events) {
        counts[event.eventType] = (counts[event.eventType] ?? 0) + 1;
      }
    }
    return counts;
  }

  void getAttendanceSummary() async {
    isLoading.value = true;
    final (summary, lastUpdateData) = await repository.getAttendanceSummary();
    attendanceSummary.value = summary;
    lastUpdate.value = lastUpdateData;
    isLoading.value = false;
  }
}
