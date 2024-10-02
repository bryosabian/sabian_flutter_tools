import 'package:flutter/material.dart';
import 'package:sabian_tools/extensions/Dates+Sabian.dart';
import 'package:sabian_tools/extensions/Strings+Sabian.dart';
import 'package:sabian_tools/modals/date/SabianDatePickerModal.dart';

class SabianDateAndTimePickerModal extends SabianDatePickerModal {
  final Function(DateTime)? onDateSelected;
  final String dateFormat;
  final String? timeTitle;
  late TimeOfDay selectedTime;
  TimeOfDay? lastSelectedTime;

  @protected
  String get modalTitle => "%s %s".format([
        (timeTitle ?? title) ?? "",
        selectedDateOrDefault.toFormattedString(dateFormat)
      ]);

  SabianDateAndTimePickerModal(super.onSelected,
      {super.minDate,
      super.maxDate,
      super.selectedDate,
      super.primaryColor,
      super.onPrimaryColor,
      super.backgroundColor,
      super.textColor,
      super.buttonColor,
      super.okayText,
      super.cancelText,
      super.title,
      this.onDateSelected,
      this.dateFormat = "yyyy-MM-dd",
      this.timeTitle}) {
    final selectedDate = selectedDateOrDefault;
    selectedTime =
        TimeOfDay(hour: selectedDate.hour, minute: selectedDate.minute);
  }

  @override
  void onDateChanged(BuildContext context, DateTime time) {
    onDateSelected?.call(time);
    showTimeDialog(context, time);
  }

  @protected
  void showTimeDialog(BuildContext context, DateTime time) async {
    TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        helpText: modalTitle,
        builder: picker);

    if (time != null && lastSelectedTime != time) {
      selectedTime = time;
      onTimeChanged(time);
      lastSelectedTime = time;
    }
  }

  @protected
  void onTimeChanged(TimeOfDay timeOfDay) {
    DateTime localDate = selectedDateOrDefault;
    selectedDate = DateTime(
        localDate.year,
        localDate.month,
        localDate.day,
        timeOfDay.hour,
        timeOfDay.minute,
        localDate.second,
        localDate.millisecond,
        localDate.microsecond);
    onSelected.call(selectedDateOrDefault);
  }
}
