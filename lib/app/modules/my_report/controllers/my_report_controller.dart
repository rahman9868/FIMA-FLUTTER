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

  final RxList<WorkCalendarEventDto> selectedEvents = <WorkCalendarEventDto>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchWorkCalendar();
  }

  Future<void> fetchWorkCalendar() async {
    try {
      isLoading(true);
      final employee = await cacheManager.getUserProfile();
      if (employee != null) {
        final now = DateTime.now();
        final result = await repository.getWorkCalendar(employee.id.toString(), now.year, now.month);
        workCalendar(result);
        selectedEvents.value = getEventsForDay(selectedDay.value ?? now);
      } else {
        errorMessage('Employee not found');
      }
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

  List<WorkCalendarEventDto> getEventsForDay(DateTime day) {
    if (workCalendar.value == null) {
      return [];
    }
    return workCalendar.value!.data.where((event) => isSameDay(event.date, day)).toList();
  }

  void onDaySelected(DateTime selected, DateTime focused) {
    if (!isSameDay(selectedDay.value, selected)) {
      selectedDay.value = selected;
      focusedDay.value = focused;
      selectedEvents.value = getEventsForDay(selected);
    }
  }
}
