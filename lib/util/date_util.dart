class DateUtil {
  String convertDate(String to) {
    String timeDiff = daysBetween(to).toString();
    String result = "Il y a $timeDiff jours";
    if (timeDiff == "0") {
      result = "aujourd'hui";
    }
    return result;
  }

  int daysBetween(String to) {
    DateTime from = DateTime.parse(to);
    DateTime toParsed = DateTime.now();
    return (toParsed.difference(from).inDays).round();
  }
}
