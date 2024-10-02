import 'package:flutter/material.dart';
import 'package:sabian_tools/modals/date/SabianDateAndTimePickerModal.dart';

class SabianTimePickerModal extends SabianDateAndTimePickerModal {
  SabianTimePickerModal(super.onSelected,
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
      super.dateFormat = "HH:mm",
      super.timeTitle});

  @override
  void show(BuildContext context) async {
    return showTimeDialog(context, selectedDateOrDefault);
  }
}
