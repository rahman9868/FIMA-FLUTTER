import 'dart:convert';

WorkCalendarDto workCalendarDtoFromJson(String str) =>
    WorkCalendarDto.fromJson(json.decode(str));

String workCalendarDtoToJson(WorkCalendarDto data) => json.encode(data.toJson());

class WorkCalendarDto {
  final List<WorkCalendarEventDto> data;

  WorkCalendarDto({
    required this.data,
  });

  factory WorkCalendarDto.fromJson(Map<String, dynamic> json) =>
      WorkCalendarDto(
        data: List<WorkCalendarEventDto>.from(
            json["data"].map((x) => WorkCalendarEventDto.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class WorkCalendarEventDto {
  final DateTime date;
  final String status;
  final String? description;

  WorkCalendarEventDto({
    required this.date,
    required this.status,
    this.description,
  });

  factory WorkCalendarEventDto.fromJson(Map<String, dynamic> json) =>
      WorkCalendarEventDto(
        date: DateTime.parse(json["date"]),
        status: json["status"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "date": date.toIso8601String(),
        "status": status,
        "description": description,
      };
}
