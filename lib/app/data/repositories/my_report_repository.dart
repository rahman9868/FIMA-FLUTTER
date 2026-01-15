import 'package:get/get.dart';
import 'package:myapp/app/data/models/work_calendar_dto.dart';
import 'package:myapp/app/data/providers/api_provider.dart';

class MyReportRepository {
  final ApiProvider _apiProvider = Get.find<ApiProvider>();

  Future<WorkCalendarDto> getWorkCalendar(String employeeId, int year, int month) {
    return _apiProvider.getWorkCalendar(employeeId, year, month);
  }
}
