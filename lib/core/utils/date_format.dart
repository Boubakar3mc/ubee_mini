class DateFormat{
  static String dasheMMddyyyy(DateTime date){
    return "${date.month.toString().padLeft(2, '0')} - ${date.day.toString().padLeft(2, '0')} - ${date.year}";
  }
  static String forFileUniqueness(DateTime dateTime){
    return "${dateTime.year}${dateTime.month}${dateTime.day}${dateTime.hour}${dateTime.minute}${dateTime.second}";
  }
}