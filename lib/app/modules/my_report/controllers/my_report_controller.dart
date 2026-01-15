import 'package:get/get.dart';
import 'package:myapp/app/data/models/work_calendar_dto.dart';
import 'package:myapp/app/data/providers/cache_manager.dart';
import 'package:myapp/app/data/repositories/my_report_repository.dart';
import 'package:table_calendar/table_calendar.dart';

class MyReportController extends GetxController {
  final MyReportRepository repository;
  final CacheManager cacheManager;

  MyReportController({required this.repository, required this.cacheManager});

  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;
  final Rx<WorkCalendarDto?> workCalendar = Rx<WorkCalendarDto?>(null);

  final Rx<DateTime> focusedDay = DateTime.now().obs;
  final Rx<DateTime?> selectedDay = DateTime.now().obs;
  late final DateTime firstDay;
  late final DateTime lastDay;

  final RxList<WorkCalendarEventDto> selectedEvents = <WorkCalendarEventDto>[].obs;

  @override
  void onInit() {
    super.onInit();
    final now = DateTime.now();
    firstDay = DateTime.utc(now.year, now.month - 1, 1);
    lastDay = DateTime.utc(now.year, now.month + 2, 0);
    fetchWorkCalendar();
  }

  Future<void> fetchWorkCalendar() async {
    try {
      isLoading.value = true;
      final employee = await cacheManager.getUserProfile();
      if (employee != null) {
        final result = await repository.getWorkCalendar(
          employee.id.toString(),
          focusedDay.value.year,
          focusedDay.value.month,
        );
        workCalendar.value = result;
        onDaySelected(selectedDay.value, focusedDay.value);
      } else {
        errorMessage.value = 'Employee ID not found.';
      }
    } catch (e) {
      errorMessage.value = 'Failed to load work calendar: $e';
    } finally {
      isLoading.value = false;
    }
  }

  List<WorkCalendarEventDto> getEventsForDay(DateTime day) {
    final events = workCalendar.value?.data ?? [];
    return events.where((event) => isSameDay(event.date, day)).toList();
  }

  void onDaySelected(DateTime? day, DateTime focused) {
    if (day != null && !isSameDay(selectedDay.value, day)) {
      selectedDay.value = day;
      focusedDay.value = focused;
      selectedEvents.value = getEventsForDay(day);
    }
  }

  void onPageChanged(DateTime focused) {
    focusedDay.value = focused;
  }
}
