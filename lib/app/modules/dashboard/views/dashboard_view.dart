import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/data/models/attendance_event_type.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: RefreshIndicator(
        onRefresh: controller.refreshSummary,
        child: Obx(
          () => controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : _buildBody(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return _buildEventGrid();
  }

  Widget _buildEventGrid() {
    final eventCounts = controller.eventCounts;
    final eventTypes = AttendanceEventType.values;

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.5,
      ),
      itemCount: eventTypes.length,
      itemBuilder: (context, index) {
        final eventType = eventTypes[index];
        final count = eventCounts[eventType] ?? 0;
        return _buildEventCard(eventType: eventType, count: count);
      },
    );
  }

  Widget _buildEventCard({
    required AttendanceEventType eventType,
    required int count,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _getIconForEventType(eventType),
            const SizedBox(height: 8),
            Text(
              eventType.value,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              count.toString(),
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: _getColorForEventType(eventType),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Icon _getIconForEventType(AttendanceEventType eventType) {
    switch (eventType) {
      case AttendanceEventType.LATE:
        return const Icon(Icons.access_time, color: Colors.orange, size: 30);
      case AttendanceEventType.ON_TIME:
        return const Icon(Icons.check_circle, color: Colors.green, size: 30);
      case AttendanceEventType.ABSENT:
        return const Icon(Icons.cancel, color: Colors.red, size: 30);
      case AttendanceEventType.PENDING:
        return const Icon(Icons.pending, color: Colors.grey, size: 30);
      case AttendanceEventType.WORKING:
        return const Icon(Icons.work, color: Colors.blue, size: 30);
      case AttendanceEventType.BUSSINES:
        return const Icon(Icons.business, color: Colors.purple, size: 30);
      case AttendanceEventType.LEAVE:
        return const Icon(Icons.time_to_leave, color: Colors.teal, size: 30);
      case AttendanceEventType.HOLIDAY:
        return const Icon(Icons.beach_access, color: Colors.pink, size: 30);
    }
  }

  Color _getColorForEventType(AttendanceEventType eventType) {
    switch (eventType) {
      case AttendanceEventType.LATE:
        return Colors.orange;
      case AttendanceEventType.ON_TIME:
        return Colors.green;
      case AttendanceEventType.ABSENT:
        return Colors.red;
      case AttendanceEventType.PENDING:
        return Colors.grey;
      case AttendanceEventType.WORKING:
        return Colors.blue;
      case AttendanceEventType.BUSSINES:
        return Colors.purple;
      case AttendanceEventType.LEAVE:
        return Colors.teal;
      case AttendanceEventType.HOLIDAY:
        return Colors.pink;
    }
  }
}
