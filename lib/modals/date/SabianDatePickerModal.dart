import 'package:flutter/material.dart';

class SabianDatePickerModal {
  DateTime minDate;
  DateTime maxDate;
  DateTime selectedDate = DateTime.now();
  Color? primaryColor;
  Color? onPrimaryColor;
  Color? backgroundColor;
  Color? textColor;
  Color? buttonColor;
  String? okayText;
  String? cancelText;
  String? title;
  Function(DateTime) onSelected;
  DateTime? lastSelectedDate;

  SabianDatePickerModal(
      this.minDate, this.maxDate, this.selectedDate, this.onSelected,
      {this.primaryColor,
      this.onPrimaryColor,
      this.backgroundColor,
      this.textColor,
      this.buttonColor,
      this.okayText,
      this.cancelText,
      this.title});

  @protected
  Widget picker(BuildContext context, Widget? child) {
    ThemeData theme = Theme.of(context);
    ColorScheme scheme = theme.colorScheme;
    return Theme(
      data: theme.copyWith(
        colorScheme: ColorScheme.light(
          primary: primaryColor ?? scheme.primary,
          // header background color
          onPrimary: onPrimaryColor ?? scheme.onPrimary,
          background: backgroundColor ?? scheme.background,
          surface: backgroundColor ?? scheme.surface,
          // header text color
          onSurface: textColor ?? scheme.onSurface, // body text color
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: buttonColor ?? scheme.primary, // button text color
          ),
        ),
      ),
      child: child!,
    );
  }

  void show(BuildContext context) async {
    DateTime? date = await showDatePicker(
      context: context,
      helpText: title,
      fieldHintText: title,
      fieldLabelText: title,
      firstDate: minDate,
      lastDate: maxDate,
      initialDate: selectedDate,
      builder: picker,
    );

    if (date != null && lastSelectedDate != date) {
      selectedDate = date;
      onDateChanged(context, date);
      lastSelectedDate = date;
    }
  }

  @protected
  void onDateChanged(BuildContext context, DateTime time) {
    onSelected.call(time);
  }
}
