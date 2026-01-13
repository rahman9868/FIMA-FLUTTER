import 'package:get/get.dart';
import 'package:myapp/app/data/models/attendance_event_type.dart';

import '../../../data/models/data_attendance_summary_dto.dart';
import '../../../data/repositories/dashboard_repository.dart';

class DashboardController extends GetxController {
  final DashboardRepository repository;

  DashboardController({required this.repository});

  final Rx<DataAttendanceSummaryDto?> summary = Rx(null);
  final RxBool isLoading = false.obs;
  final RxMap<AttendanceEventType, int> eventCounts = RxMap();
  final Rx<DateTime?> lastUpdate = Rx(null);

  @override
  void onInit() {
    super.onInit();
    fetchSummary();
  }

  Future<void> fetchSummary() async {
    isLoading.value = true;
    try {
      final (result, timestamp) = await repository.getAttendanceSummary();
      summary.value = result;
      lastUpdate.value = timestamp;
      _calculateEventCounts();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch summary');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshSummary() async {
    try {
      final (result, timestamp) = await repository.refreshAttendanceSummary();
      summary.value = result;
      lastUpdate.value = timestamp;
      _calculateEventCounts();
    } catch (e) {
      Get.snackbar('Error', 'Failed to refresh summary');
    }
  }

  void _calculateEventCounts() {
    // Initialize all counts to 0
    final counts = <AttendanceEventType, int>{
      for (var type in AttendanceEventType.values) type: 0,
    };

    final summaryData = summary.value?.data;
    if (summaryData != null && summaryData.isNotEmpty) {
      final events = summaryData.first.event;
      if (events != null) {
        for (var event in events) {
          try {
            final eventType = AttendanceEventType.values.firstWhere(
              (e) => e.value == event.eventType,
            );
            counts[eventType] = (counts[eventType] ?? 0) + 1;
          } catch (e) {
            // Handle cases where the event type from the API is not in our enum
            print("Unknown event type: ${event.eventType}");
          }
        }
      }
    }
    eventCounts.value = counts;
  }
}
