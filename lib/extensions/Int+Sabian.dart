extension SabianIntExtensions on int {
  String get toHoursMinutesSeconds {
    final totalSeconds = this;
    final duration = Duration(seconds: totalSeconds);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    final hoursDescription = hours.toString().padLeft(2,'0');
    final minutesDescription = minutes.toString().padLeft(2,'0');
    final secondsDescription = seconds.toString().padLeft(2,'0');
    final formattedTime = '$hoursDescription:$minutesDescription:$secondsDescription';
    return formattedTime;
  }
}

extension SabianDoubleExtensions on double {
  String get toHoursMinutesSeconds {
   return this.toInt().toHoursMinutesSeconds;
  }
}
