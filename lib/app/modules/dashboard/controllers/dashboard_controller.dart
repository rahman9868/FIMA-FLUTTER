import 'package:get/get.dart';

import '../../../data/models/data_attendance_summary_dto.dart';
import '../../../data/repositories/dashboard_repository.dart';

class DashboardController extends GetxController {
  final DashboardRepository repository;

  DashboardController({required this.repository});

  final Rx<DataAttendanceSummaryDto?> summary = Rx(null);
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSummary();
  }

  Future<void> fetchSummary() async {
    isLoading.value = true;
    try {
      final result = await repository.getAttendanceSummary();
      summary.value = result;
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch summary');
    }
    isLoading.value = false;
  }

  Future<void> refreshSummary() async {
    try {
      final result = await repository.refreshAttendanceSummary();
      summary.value = result;
    } catch (e) {
      Get.snackbar('Error', 'Failed to refresh summary');
    }
  }
}
