import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:myapp/app/modules/my_report/controllers/my_report_controller.dart';

class MyReportView extends GetView<MyReportController> {
  const MyReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Report'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.errorMessage.value.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        } else {
          return SingleChildScrollView(
            child: Column(
              children: [
                TableCalendar(
                  firstDay: controller.firstDay,
                  lastDay: controller.lastDay,
                  focusedDay: controller.focusedDay.value,
                  selectedDayPredicate: (day) => isSameDay(controller.selectedDay.value, day),
                  calendarFormat: CalendarFormat.month,
                  eventLoader: controller.getEventsForDay,
                  onDaySelected: controller.onDaySelected,
                  onPageChanged: controller.onPageChanged,
                  calendarStyle: CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                  ),
                  headerStyle: const HeaderStyle(
                    titleCentered: true,
                    formatButtonVisible: false,
                  ),
                ),
                const SizedBox(height: 20),
                _buildEventList(),
              ],
            ),
          );
        }
      }),
    );
  }

  Widget _buildEventList() {
    return Obx(() {
      if (controller.selectedEvents.isEmpty) {
        return const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('No events for this day'),
        );
      }

      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.selectedEvents.length,
        itemBuilder: (context, index) {
          final event = controller.selectedEvents[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(event.description ?? 'No description'),
              trailing: Text(event.status ?? 'N/A'),
            ),
          );
        },
      );
    });
  }
}
