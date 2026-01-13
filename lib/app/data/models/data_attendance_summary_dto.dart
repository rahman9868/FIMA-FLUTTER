import 'dart:convert';

DataAttendanceSummaryDto dataAttendanceSummaryDtoFromJson(String str) =>
    DataAttendanceSummaryDto.fromJson(json.decode(str));

String dataAttendanceSummaryDtoToJson(DataAttendanceSummaryDto data) =>
    json.encode(data.toJson());

class DataAttendanceSummaryDto {
  final List<AttendanceSummaryDataDto>? data;

  DataAttendanceSummaryDto({this.data});

  factory DataAttendanceSummaryDto.fromJson(Map<String, dynamic> json) =>
      DataAttendanceSummaryDto(
        data: json["data"] == null
            ? []
            : List<AttendanceSummaryDataDto>.from(
                json["data"]!.map((x) => AttendanceSummaryDataDto.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class AttendanceSummaryDataDto {
  final int employeeId;
  final int year;
  final int month;
  final List<AttendanceSummaryDto>? event;

  AttendanceSummaryDataDto({
    required this.employeeId,
    required this.year,
    required this.month,
    this.event,
  });

  factory AttendanceSummaryDataDto.fromJson(Map<String, dynamic> json) =>
      AttendanceSummaryDataDto(
        employeeId: json["employeeId"],
        year: json["year"],
        month: json["month"],
        event: json["event"] == null
            ? []
            : List<AttendanceSummaryDto>.from(
                json["event"]!.map((x) => AttendanceSummaryDto.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
    "employeeId": employeeId,
    "year": year,
    "month": month,
    "event": event == null
        ? []
        : List<dynamic>.from(event!.map((x) => x.toJson())),
  };
}

class AttendanceSummaryDto {
  final int day;
  final String eventType;

  AttendanceSummaryDto({required this.day, required this.eventType});

  factory AttendanceSummaryDto.fromJson(Map<String, dynamic> json) =>
      AttendanceSummaryDto(day: json["day"], eventType: json["eventType"]);

  Map<String, dynamic> toJson() => {"day": day, "eventType": eventType};
}
