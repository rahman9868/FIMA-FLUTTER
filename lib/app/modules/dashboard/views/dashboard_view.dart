import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
              : _buildSummary(),
        ),
      ),
    );
  }

  Widget _buildSummary() {
    final summary = controller.summary.value;
    if (summary == null) {
      return const Center(child: Text('No data'));
    }
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSummaryCard(
          title: 'Present',
          value: summary.totalPresent.toString(),
          color: Colors.green,
        ),
        const SizedBox(height: 16),
        _buildSummaryCard(
          title: 'Absent',
          value: summary.totalAbsent.toString(),
          color: Colors.red,
        ),
        const SizedBox(height: 16),
        _buildSummaryCard(
          title: 'Leave',
          value: summary.totalLeave.toString(),
          color: Colors.orange,
        ),
      ],
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required String value,
    required Color color,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
