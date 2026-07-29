import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

/// Shows a dialog containing a [TectaCalendar] to pick a single date.
Future<DateTime?> showTectaDatePicker({
  required BuildContext context,
  required DateTime initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
  Color? selectedColor,
  Color? todayColor,
  TextStyle? headerTextStyle,
  TextStyle? weekdayTextStyle,
  TextStyle? dayTextStyle,
  TextStyle? selectedDayTextStyle,
  TextStyle? todayTextStyle,
  Widget? confirmButton,
  Widget? cancelButton,
  String? title,
  List<String>? monthNames,
  List<String>? weekdays,
  TextStyle? weekendHeaderTextStyle,
  TextStyle? weekendDayTextStyle,
}) async {
  DateTime tempDate = initialDate;

  return showDialog<DateTime>(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
            backgroundColor: Colors.white,
            clipBehavior: Clip.antiAlias,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 360),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (title != null) ...[
                      Text(
                        title,
                        style: TectaTypography.subtitle1.copyWith(
                          fontWeight: FontWeight.bold,
                          color: TectaColors.grey800,
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                    TectaCalendar(
                      selectedDate: tempDate,
                      selectionMode: TectaCalendarSelectionMode.single,
                      firstDate: firstDate,
                      lastDate: lastDate,
                      selectedColor: selectedColor,
                      todayColor: todayColor,
                      headerTextStyle: headerTextStyle,
                      weekdayTextStyle: weekdayTextStyle,
                      dayTextStyle: dayTextStyle,
                      selectedDayTextStyle: selectedDayTextStyle,
                      todayTextStyle: todayTextStyle,
                      monthNames: monthNames,
                      weekdays: weekdays,
                      weekendHeaderTextStyle: weekendHeaderTextStyle,
                      weekendDayTextStyle: weekendDayTextStyle,
                      onDateSelected: (date) {
                        setState(() {
                          tempDate = date;
                        });
                      },
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        cancelButton ??
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                MaterialLocalizations.of(context).cancelButtonLabel,
                                style: TectaTypography.subtitle2.copyWith(
                                  color: TectaColors.grey500,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        const SizedBox(width: 8),
                        confirmButton ??
                            TectaButton(
                              label: MaterialLocalizations.of(context).okButtonLabel,
                              onPressed: () => Navigator.pop(context, tempDate),
                            ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

/// Shows a dialog containing a [TectaCalendar] to pick a date range.
Future<DateTimeRange?> showTectaDateRangePicker({
  required BuildContext context,
  required DateTime? initialStartDate,
  required DateTime? initialEndDate,
  DateTime? firstDate,
  DateTime? lastDate,
  Color? selectedColor,
  Color? todayColor,
  Color? rangeColor,
  TextStyle? headerTextStyle,
  TextStyle? weekdayTextStyle,
  TextStyle? dayTextStyle,
  TextStyle? selectedDayTextStyle,
  TextStyle? todayTextStyle,
  Widget? confirmButton,
  Widget? cancelButton,
  String? title,
  List<String>? monthNames,
  List<String>? weekdays,
  TextStyle? weekendHeaderTextStyle,
  TextStyle? weekendDayTextStyle,
}) async {
  DateTime? tempStart = initialStartDate;
  DateTime? tempEnd = initialEndDate;

  return showDialog<DateTimeRange>(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
            backgroundColor: Colors.white,
            clipBehavior: Clip.antiAlias,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 360),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (title != null) ...[
                      Text(
                        title,
                        style: TectaTypography.subtitle1.copyWith(
                          fontWeight: FontWeight.bold,
                          color: TectaColors.grey800,
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                    TectaCalendar(
                      rangeStartDate: tempStart,
                      rangeEndDate: tempEnd,
                      selectionMode: TectaCalendarSelectionMode.range,
                      firstDate: firstDate,
                      lastDate: lastDate,
                      selectedColor: selectedColor,
                      todayColor: todayColor,
                      rangeColor: rangeColor,
                      headerTextStyle: headerTextStyle,
                      weekdayTextStyle: weekdayTextStyle,
                      dayTextStyle: dayTextStyle,
                      selectedDayTextStyle: selectedDayTextStyle,
                      todayTextStyle: todayTextStyle,
                      monthNames: monthNames,
                      weekdays: weekdays,
                      weekendHeaderTextStyle: weekendHeaderTextStyle,
                      weekendDayTextStyle: weekendDayTextStyle,
                      onRangeSelected: (start, end) {
                        setState(() {
                          tempStart = start;
                          tempEnd = end;
                        });
                      },
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        cancelButton ??
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                MaterialLocalizations.of(context).cancelButtonLabel,
                                style: TectaTypography.subtitle2.copyWith(
                                  color: TectaColors.grey500,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        const SizedBox(width: 8),
                        confirmButton ??
                            TectaButton(
                              label: MaterialLocalizations.of(context).okButtonLabel,
                              onPressed: () {
                                if (tempStart != null && tempEnd != null) {
                                  Navigator.pop(
                                      context, DateTimeRange(start: tempStart!, end: tempEnd!));
                                } else {
                                  Navigator.pop(context);
                                }
                              },
                            ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

/// Shows a dialog containing a [TectaMonthPicker] to pick a month.
Future<int?> showTectaMonthPicker({
  required BuildContext context,
  required int initialMonth,
  Color? selectedColor,
  TextStyle? gridTextStyle,
  TextStyle? selectedGridTextStyle,
  Widget? confirmButton,
  Widget? cancelButton,
  List<String>? monthNames,
  String? title,
}) async {
  int tempMonth = initialMonth;

  return showDialog<int>(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
            backgroundColor: Colors.white,
            clipBehavior: Clip.antiAlias,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 320),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title ?? 'Select Month',
                      style: TectaTypography.subtitle1.copyWith(
                        fontWeight: FontWeight.bold,
                        color: TectaColors.grey800,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TectaMonthPicker(
                      selectedMonth: tempMonth,
                      selectedColor: selectedColor,
                      gridTextStyle: gridTextStyle,
                      selectedGridTextStyle: selectedGridTextStyle,
                      monthNames: monthNames,
                      onMonthSelected: (month) {
                        setState(() {
                          tempMonth = month;
                        });
                      },
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        cancelButton ??
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                MaterialLocalizations.of(context).cancelButtonLabel,
                                style: TectaTypography.subtitle2.copyWith(
                                  color: TectaColors.grey500,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        const SizedBox(width: 8),
                        confirmButton ??
                            TectaButton(
                              label: MaterialLocalizations.of(context).okButtonLabel,
                              onPressed: () => Navigator.pop(context, tempMonth),
                            ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

/// Shows a dialog containing a [TectaYearPicker] to pick a year.
Future<int?> showTectaYearPicker({
  required BuildContext context,
  required int initialYear,
  int? firstYear,
  int? lastYear,
  Color? selectedColor,
  TextStyle? gridTextStyle,
  TextStyle? selectedGridTextStyle,
  Widget? confirmButton,
  Widget? cancelButton,
  String? title,
}) async {
  int tempYear = initialYear;

  return showDialog<int>(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
            backgroundColor: Colors.white,
            clipBehavior: Clip.antiAlias,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 320),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title ?? 'Select Year',
                      style: TectaTypography.subtitle1.copyWith(
                        fontWeight: FontWeight.bold,
                        color: TectaColors.grey800,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TectaYearPicker(
                      selectedYear: tempYear,
                      firstYear: firstYear,
                      lastYear: lastYear,
                      selectedColor: selectedColor,
                      gridTextStyle: gridTextStyle,
                      selectedGridTextStyle: selectedGridTextStyle,
                      onYearSelected: (year) {
                        setState(() {
                          tempYear = year;
                        });
                      },
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        cancelButton ??
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                MaterialLocalizations.of(context).cancelButtonLabel,
                                style: TectaTypography.subtitle2.copyWith(
                                  color: TectaColors.grey500,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        const SizedBox(width: 8),
                        confirmButton ??
                            TectaButton(
                              label: MaterialLocalizations.of(context).okButtonLabel,
                              onPressed: () => Navigator.pop(context, tempYear),
                            ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

/// Shows a dialog containing a [TectaTimePicker] to pick a time of day.
Future<TimeOfDay?> showTectaTimePicker({
  required BuildContext context,
  required TimeOfDay initialTime,
  TectaTimeFormat format = TectaTimeFormat.h24,
  TectaTimePickerStyle style = TectaTimePickerStyle.wheel,
  Color? activeColor,
  TextStyle? timeTextStyle,
  TextStyle? ampmTextStyle,
  Widget? confirmButton,
  Widget? cancelButton,
  String? title,
}) async {
  TimeOfDay tempTime = initialTime;

  return showDialog<TimeOfDay>(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        backgroundColor: Colors.white,
        clipBehavior: Clip.antiAlias,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 320),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title ?? 'Select Time',
                  style: TectaTypography.subtitle1.copyWith(
                    fontWeight: FontWeight.bold,
                    color: TectaColors.grey800,
                  ),
                ),
                const SizedBox(height: 16),
                TectaTimePicker(
                  initialTime: tempTime,
                  format: format,
                  style: style,
                  activeColor: activeColor,
                  timeTextStyle: timeTextStyle,
                  ampmTextStyle: ampmTextStyle,
                  onTimeChanged: (time) {
                    tempTime = time;
                  },
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    cancelButton ??
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            MaterialLocalizations.of(context).cancelButtonLabel,
                            style: TectaTypography.subtitle2.copyWith(
                              color: TectaColors.grey500,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    const SizedBox(width: 8),
                    confirmButton ??
                        TectaButton(
                          label: MaterialLocalizations.of(context).okButtonLabel,
                          onPressed: () => Navigator.pop(context, tempTime),
                        ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
