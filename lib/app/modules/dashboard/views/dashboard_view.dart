import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myapp/app/data/models/attendance_event_type.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    // The Scaffold, AppBar, and Drawer are now in MainView.
    // This widget only provides the body content for the dashboard.
    return RefreshIndicator(
      onRefresh: controller.refreshSummary,
      child: Obx(
        () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSummaryHeader(),
        const SizedBox(height: 16),
        _buildEventList(),
      ],
    );
  }

  Widget _buildSummaryHeader() {
    final lastUpdate = controller.lastUpdate.value;
    final formattedDate = lastUpdate != null
        ? DateFormat('yyyy-MM-dd HH:mm:ss').format(lastUpdate)
        : 'Unknown';

    return Column(
      children: [
        Text('Last Update: $formattedDate'),
        const Text('Please Pull to Refresh'),
      ],
    );
  }

  Widget _buildEventList() {
    final eventCounts = controller.eventCounts;
    final eventTypes = [
      AttendanceEventType.WORKING,
      AttendanceEventType.ON_TIME,
      AttendanceEventType.LATE,
      AttendanceEventType.ABSENT,
      AttendanceEventType.BUSSINES,
      AttendanceEventType.LEAVE,
      AttendanceEventType.PENDING,
    ];

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: eventTypes.map((eventType) {
            final count = eventCounts[eventType] ?? 0;
            return _buildEventRow(eventType: eventType, count: count);
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildEventRow({
    required AttendanceEventType eventType,
    required int count,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          _getIconForEventType(eventType),
          const SizedBox(width: 16),
          Text(eventType.value),
          const Spacer(),
          const Text(':'),
          const SizedBox(width: 16),
          Text(count.toString()),
        ],
      ),
    );
  }

  Icon _getIconForEventType(AttendanceEventType eventType) {
    switch (eventType) {
      case AttendanceEventType.LATE:
        return const Icon(Icons.flag, color: Colors.yellow);
      case AttendanceEventType.ON_TIME:
        return const Icon(Icons.flag, color: Colors.green);
      case AttendanceEventType.ABSENT:
        return const Icon(Icons.flag, color: Colors.red);
      case AttendanceEventType.PENDING:
        return const Icon(Icons.flag, color: Colors.orange);
      case AttendanceEventType.WORKING:
        return const Icon(Icons.bookmark_border, color: Colors.grey);
      case AttendanceEventType.BUSSINES:
        return const Icon(Icons.flag, color: Colors.blue);
      case AttendanceEventType.LEAVE:
        return const Icon(Icons.flag, color: Colors.purple);
      case AttendanceEventType.HOLIDAY:
        return const Icon(Icons.flag, color: Colors.pink);
    }
  }
}
