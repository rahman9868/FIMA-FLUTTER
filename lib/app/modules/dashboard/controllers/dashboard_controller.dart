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
    final counts = <AttendanceEventType, int>{
      for (var type in AttendanceEventType.values) type: 0,
    };

    final summaryData = summary.value?.data;
    if (summaryData != null && summaryData.isNotEmpty) {
      final events = summaryData.first.event;
      if (events != null) {
        final dayNow = DateTime.now().day;

        final onTime = events
            .where((e) =>
                e.eventType.toLowerCase() ==
                AttendanceEventType.ON_TIME.value.toLowerCase())
            .length;
        final late = events
            .where((e) =>
                e.eventType.toLowerCase() ==
                AttendanceEventType.LATE.value.toLowerCase())
            .length;
        final absent = events
            .where((e) =>
                e.eventType.toLowerCase() ==
                AttendanceEventType.ABSENT.value.toLowerCase())
            .length;
        final businessTrip = events
            .where((e) =>
                e.eventType.toLowerCase() ==
                AttendanceEventType.BUSSINES.value.toLowerCase())
            .length;
        final leave = events
            .where((e) =>
                e.eventType.toLowerCase() ==
                AttendanceEventType.LEAVE.value.toLowerCase())
            .length;
        final pending = events
            .where((e) =>
                e.eventType.toLowerCase() ==
                AttendanceEventType.PENDING.value.toLowerCase())
            .length;
        final holiday = events
            .where((e) =>
                e.eventType.toLowerCase() ==
                AttendanceEventType.HOLIDAY.value.toLowerCase())
            .length;

        final leaveDays = events
            .where(
              (e) =>
                  e.eventType.toLowerCase() ==
                      AttendanceEventType.LEAVE.value.toLowerCase() &&
                  e.day <= dayNow,
            )
            .length;
        final businessDays = events
            .where(
              (e) =>
                  e.eventType.toLowerCase() ==
                      AttendanceEventType.BUSSINES.value.toLowerCase() &&
                  e.day <= dayNow,
            )
            .length;

        final workingDays =
            businessDays + onTime + late + pending + absent + leaveDays;

        counts[AttendanceEventType.ON_TIME] = onTime;
        counts[AttendanceEventType.LATE] = late;
        counts[AttendanceEventType.ABSENT] = absent;
        counts[AttendanceEventType.BUSSINES] = businessTrip;
        counts[AttendanceEventType.LEAVE] = leave;
        counts[AttendanceEventType.PENDING] = pending;
        counts[AttendanceEventType.HOLIDAY] = holiday;
        counts[AttendanceEventType.WORKING] = workingDays;
      }
    }

    eventCounts.value = counts;
  }
}
