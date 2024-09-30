class DateRangeHelper {
  static String getDateRange(String timeRange) {
    DateTime now = DateTime.now();

    if (timeRange == 'Last Day') {
      return now
          .subtract(const Duration(days: 1))
          .toIso8601String()
          .split('T')[0];
    } else if (timeRange == 'Last Week') {
      return now
          .subtract(const Duration(days: 7))
          .toIso8601String()
          .split('T')[0];
    } else {
      return now
          .subtract(const Duration(days: 30))
          .toIso8601String()
          .split('T')[0];
    }
  }
}
