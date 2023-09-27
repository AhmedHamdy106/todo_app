class MyDateTime {
  static DateTime exctractDateonly(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day);
  }
}
