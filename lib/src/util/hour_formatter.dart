extension HourFormatter on String{
  Duration toDuration(){
    final List<String> divider = replaceAll(RegExp(r"\."), '').split(RegExp(r"\:|\s"));
    final int hour = int.parse(divider[0]);
    final String minutes = divider[1], format = divider[2];
    return Duration(hours: format == 'AM' ? hour : hour + 12, minutes: int.parse(minutes));
  }
}