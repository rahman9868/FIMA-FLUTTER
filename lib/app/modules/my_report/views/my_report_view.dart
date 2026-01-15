import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/data/models/attendance_event_type.dart';
import 'package:myapp/app/modules/my_report/controllers/my_report_controller.dart';
import 'package:table_calendar/table_calendar.dart';

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
        } else if (controller.workCalendar.value == null) {
          return const Center(child: Text('No data found'));
        } else {
          return Column(
            children: [
              TableCalendar(
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: controller.focusedDay.value,
                selectedDayPredicate: (day) {
                  return isSameDay(controller.selectedDay.value, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  controller.onDaySelected(selectedDay, focusedDay);
                },
                eventLoader: (day) {
                  return controller.getEventsForDay(day);
                },
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (context, date, events) {
                    if (events.isNotEmpty) {
                      return Positioned(
                        right: 1,
                        bottom: 1,
                        child: _buildEventsMarker(events),
                      );
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 8.0),
              Expanded(
                child: _buildEventList(),
              ),
            ],
          );
        }
      }),
    );
  }

  Widget _buildEventsMarker(List<dynamic> events) {
    return Row(
      children: events.map((event) => _getIconForStatus(event.status)).toList(),
    );
  }

  Widget _buildEventList() {
    return Obx(() {
      final selectedEvents = controller.selectedEvents;
      if (selectedEvents.isEmpty) {
        return const Center(child: Text("No events for this day"));
      }
      return ListView.builder(
        itemCount: selectedEvents.length,
        itemBuilder: (context, index) {
          final event = selectedEvents[index];
          return ListTile(
            leading: _getIconForStatus(event.status),
            title: Text(event.status),
            subtitle: Text(event.description ?? ''),
          );
        },
      );
    });
  }

  Icon _getIconForStatus(String status) {
    switch (status) {
      case 'LATE':
        return const Icon(Icons.flag, color: Colors.yellow);
      case 'ON_TIME':
        return const Icon(Icons.flag, color: Colors.green);
      case 'ABSENT':
        return const Icon(Icons.flag, color: Colors.red);
      case 'PENDING':
        return const Icon(Icons.flag, color: Colors.orange);
      case 'WORKING':
        return const Icon(Icons.bookmark_border, color: Colors.grey);
      case 'BUSSINES':
        return const Icon(Icons.flag, color: Colors.blue);
      case 'LEAVE':
        return const Icon(Icons.flag, color: Colors.purple);
      case 'HOLIDAY':
        return const Icon(Icons.flag, color: Colors.pink);
      default:
        return const Icon(Icons.flag, color: Colors.grey);
    }
  }
}
