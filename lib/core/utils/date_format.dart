class DateFormat{
  static String dasheMMddyyyy(DateTime date){
    return "${date.month.toString().padLeft(2, '0')} - ${date.day.toString().padLeft(2, '0')} - ${date.year}";
  }
}