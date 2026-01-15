import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:myapp/app/data/models/attendance_event_type.dart';
import 'package:myapp/app/data/models/work_calendar_dto.dart';
import 'package:myapp/app/modules/my_report/controllers/my_report_controller.dart';

// Helper function to convert a status string to an AttendanceEventType.
AttendanceEventType _getEventType(String? status) {
  // Handle a potential 'present' status and map it to ON_TIME
  if (status?.toLowerCase() == 'present') {
    return AttendanceEventType.ON_TIME;
  }
  // Find the matching enum value from the official list.
  return AttendanceEventType.values.firstWhere(
    (e) => e.value.toLowerCase() == status?.toLowerCase(),
    orElse: () => AttendanceEventType.WORKING, // Default for unknown statuses
  );
}

// Returns the appropriate icon and color for a given event type.
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
                TableCalendar<WorkCalendarEventDto>(
                  firstDay: controller.firstDay,
                  lastDay: controller.lastDay,
                  focusedDay: controller.focusedDay.value,
                  selectedDayPredicate: (day) =>
                      isSameDay(controller.selectedDay.value, day),
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
                  calendarBuilders: CalendarBuilders(
                    markerBuilder: (context, day, events) {
                      if (events.isEmpty) return null;

                      // Display a row of small flag icons as event markers.
                      return Positioned(
                        bottom: 4,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: events.map((event) {
                            final eventType = _getEventType(event.status);
                            final icon = _getIconForEventType(eventType);
                            return Icon(icon.icon, color: icon.color, size: 14);
                          }).toList(),
                        ),
                      );
                    },
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
          final eventType = _getEventType(event.status);
          final icon = _getIconForEventType(eventType);

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              // Display the full-sized flag icon in the list.
              leading: icon,
              title: Text(event.description ?? 'No description'),
              trailing: Text(
                event.status ?? 'N/A',
                style: TextStyle(color: icon.color, fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      );
    });
  }
}
