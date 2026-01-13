enum AttendanceEventType {
  LATE("LATE"),
  ON_TIME("ON_TIME"),
  ABSENT("ABSENT"),
  PENDING("PENDING"),
  WORKING("WORKING"),
  BUSSINES("BUSINESS"),
  LEAVE("LEAVE"),
  HOLIDAY("HOLIDAY");

  const AttendanceEventType(this.value);
  final String value;
}
