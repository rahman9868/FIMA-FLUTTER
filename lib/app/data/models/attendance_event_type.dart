enum AttendanceEventType {
  LATE('Late'),
  ON_TIME('On-Time'),
  ABSENT('Absent'),
  PENDING('Pending'),
  WORKING('Working Days'),
  BUSSINES('Business Trip'),
  LEAVE('Leave'),
  HOLIDAY('Holiday');

  const AttendanceEventType(this.value);
  final String value;
}
