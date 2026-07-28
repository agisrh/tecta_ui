import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

/// Selection mode for [TectaCalendar].
enum TectaCalendarSelectionMode {
  /// Selecting a single date.
  single,
  /// Selecting a date range.
  range
}

/// A premium, highly customizable Calendar component for the Tecta Design System.
class TectaCalendar extends StatefulWidget {
  /// The current selected date (for [TectaCalendarSelectionMode.single]).
  final DateTime? selectedDate;

  /// Callback when a single date is selected.
  final ValueChanged<DateTime>? onDateSelected;

  /// The start date of the range (for [TectaCalendarSelectionMode.range]).
  final DateTime? rangeStartDate;

  /// The end date of the range (for [TectaCalendarSelectionMode.range]).
  final DateTime? rangeEndDate;

  /// Callback when a range is selected.
  final Function(DateTime? start, DateTime? end)? onRangeSelected;

  /// The selection mode. Defaults to [TectaCalendarSelectionMode.single].
  final TectaCalendarSelectionMode selectionMode;

  /// The minimum selectable date.
  final DateTime? firstDate;

  /// The maximum selectable date.
  final DateTime? lastDate;

  /// Custom background color of the active/selected day.
  final Color? selectedColor;

  /// Custom color of the today marker.
  final Color? todayColor;

  /// Custom color of the range background highlight.
  final Color? rangeColor;

  /// Text style for the month/year header.
  final TextStyle? headerTextStyle;

  /// Text style for weekdays (Mo, Tu, We, etc.).
  final TextStyle? weekdayTextStyle;

  /// Text style for days.
  final TextStyle? dayTextStyle;

  /// Text style for the selected day.
  final TextStyle? selectedDayTextStyle;

  /// Text style for today.
  final TextStyle? todayTextStyle;

  /// Custom list of 7 weekday string representations.
  final List<String>? weekdays;

  const TectaCalendar({
    super.key,
    this.selectedDate,
    this.onDateSelected,
    this.rangeStartDate,
    this.rangeEndDate,
    this.onRangeSelected,
    this.selectionMode = TectaCalendarSelectionMode.single,
    this.firstDate,
    this.lastDate,
    this.selectedColor,
    this.todayColor,
    this.rangeColor,
    this.headerTextStyle,
    this.weekdayTextStyle,
    this.dayTextStyle,
    this.selectedDayTextStyle,
    this.todayTextStyle,
    this.weekdays,
    this.monthNames,
    this.events,
    this.weekendHeaderTextStyle,
    this.weekendDayTextStyle,
  });

  /// Custom list of 12 month string representations for the calendar header.
  final List<String>? monthNames;

  /// Optional list of events to display as indicators under dates on the calendar.
  final List<TectaCalendarEvent>? events;

  /// Custom text style for weekend column headers (Saturday and Sunday).
  final TextStyle? weekendHeaderTextStyle;

  /// Custom text style for weekend days (Saturday and Sunday).
  final TextStyle? weekendDayTextStyle;

  @override
  State<TectaCalendar> createState() => _TectaCalendarState();
}

class _TectaCalendarState extends State<TectaCalendar> {
  late DateTime _currentMonth;

  @override
  void initState() {
    super.initState();
    _currentMonth = widget.selectedDate ?? widget.rangeStartDate ?? DateTime.now();
  }

  void _prevMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);
    });
  }

  List<String> _getWeekdays(BuildContext context) {
    if (widget.weekdays != null) return widget.weekdays!;
    final localizations = MaterialLocalizations.of(context);
    final List<String> list = List.from(localizations.narrowWeekdays);
    if (list.length >= 7) {
      final sunday = list.removeAt(0);
      list.add(sunday);
    }
    return list;
  }

  List<DateTime?> _generateDaysInMonth() {
    final firstDayOfMonth = DateTime(_currentMonth.year, _currentMonth.month, 1);
    final lastDayOfMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 0);

    int leadingEmptyDays = firstDayOfMonth.weekday - 1;
    final List<DateTime?> days = List.generate(leadingEmptyDays, (_) => null);

    for (int i = 1; i <= lastDayOfMonth.day; i++) {
      days.add(DateTime(_currentMonth.year, _currentMonth.month, i));
    }

    return days;
  }

  bool _isSameDay(DateTime? a, DateTime? b) {
    if (a == null || b == null) return false;
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }

  bool _isDayInRange(DateTime date) {
    if (widget.selectionMode != TectaCalendarSelectionMode.range) return false;
    final start = widget.rangeStartDate;
    final end = widget.rangeEndDate;
    if (start == null || end == null) return false;
    return date.isAfter(start) && date.isBefore(end);
  }

  bool _isSelectable(DateTime date) {
    if (widget.firstDate != null && date.isBefore(widget.firstDate!)) return false;
    if (widget.lastDate != null && date.isAfter(widget.lastDate!)) return false;
    return true;
  }

  void _handleDayTap(DateTime date) {
    if (!_isSelectable(date)) return;

    if (widget.selectionMode == TectaCalendarSelectionMode.single) {
      widget.onDateSelected?.call(date);
    } else {
      final start = widget.rangeStartDate;
      final end = widget.rangeEndDate;

      if (start == null || end != null) {
        widget.onRangeSelected?.call(date, null);
      } else {
        if (date.isBefore(start)) {
          widget.onRangeSelected?.call(date, null);
        } else {
          widget.onRangeSelected?.call(start, date);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = widget.selectedColor ?? TectaColors.primaryMain;
    final activeTodayColor = widget.todayColor ?? TectaColors.infoMain;
    final activeRangeBg = widget.rangeColor ?? TectaColors.primaryMain.withValues(alpha: 0.12);

    final resolvedPrimary = TectaColors.resolve(context, primaryColor);
    final resolvedToday = TectaColors.resolve(context, activeTodayColor);
    final resolvedRangeBg = TectaColors.resolve(context, activeRangeBg);

    final List<DateTime?> days = _generateDaysInMonth();
    
    String monthYearString;
    if (widget.monthNames != null && widget.monthNames!.length == 12) {
      monthYearString = '${widget.monthNames![_currentMonth.month - 1]} ${_currentMonth.year}';
    } else {
      monthYearString = MaterialLocalizations.of(context).formatMonthYear(_currentMonth);
    }

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 360.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
        // Calendar Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left),
              color: TectaColors.grey600,
              onPressed: _prevMonth,
            ),
            Text(
              monthYearString,
              style: widget.headerTextStyle ??
                  TectaTypography.subtitle1.copyWith(
                    fontWeight: FontWeight.bold,
                    color: TectaColors.grey800,
                  ),
            ),
            IconButton(
              icon: const Icon(Icons.chevron_right),
              color: TectaColors.grey600,
              onPressed: _nextMonth,
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Weekdays Grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
          ),
          itemCount: 7,
          itemBuilder: (context, index) {
            final isWeekend = index == 5 || index == 6;
            final defaultStyle = TectaTypography.caption.copyWith(
              color: TectaColors.grey500,
              fontWeight: FontWeight.w600,
            );
            final resolvedStyle = isWeekend
                ? (widget.weekendHeaderTextStyle ?? widget.weekdayTextStyle ?? defaultStyle)
                : (widget.weekdayTextStyle ?? defaultStyle);

            return Center(
              child: Text(
                _getWeekdays(context)[index],
                style: resolvedStyle,
              ),
            );
          },
        ),
        const SizedBox(height: 4),
        // Days Grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
          ),
          itemCount: days.length,
          itemBuilder: (context, index) {
            final day = days[index];
            if (day == null) {
              return const SizedBox.shrink();
            }

            final bool isSelected = (widget.selectionMode == TectaCalendarSelectionMode.single &&
                    _isSameDay(day, widget.selectedDate)) ||
                (widget.selectionMode == TectaCalendarSelectionMode.range &&
                    (_isSameDay(day, widget.rangeStartDate) || _isSameDay(day, widget.rangeEndDate)));

            final bool isToday = _isToday(day);
            final bool inRange = _isDayInRange(day);
            final bool isSelectable = _isSelectable(day);

            Color? dayBgColor;
            Border? dayBorder;
            BorderRadiusGeometry dayBorderRadius = BorderRadius.circular(50.0);

            if (isSelected) {
              dayBgColor = resolvedPrimary;
            } else if (inRange) {
              dayBgColor = resolvedRangeBg;
              dayBorderRadius = BorderRadius.zero;
            } else if (isToday) {
              dayBorder = Border.all(color: resolvedToday, width: 1.5);
            }

            if (widget.selectionMode == TectaCalendarSelectionMode.range && isSelected) {
              if (_isSameDay(day, widget.rangeStartDate) && widget.rangeEndDate != null) {
                dayBorderRadius = const BorderRadius.only(
                  topLeft: Radius.circular(50.0),
                  bottomLeft: Radius.circular(50.0),
                );
              } else if (_isSameDay(day, widget.rangeEndDate)) {
                dayBorderRadius = const BorderRadius.only(
                  topRight: Radius.circular(50.0),
                  bottomRight: Radius.circular(50.0),
                );
              }
            }

            final bool isWeekendDay = day.weekday == DateTime.saturday || day.weekday == DateTime.sunday;

            final Color dayTextColor = !isSelectable
                ? TectaColors.grey300
                : isSelected
                    ? (resolvedPrimary.computeLuminance() > 0.5 ? TectaColors.grey900 : Colors.white)
                    : isToday
                        ? resolvedToday
                        : isWeekendDay
                            ? (widget.weekendDayTextStyle?.color ?? TectaColors.errorMain)
                            : TectaColors.grey800;

            final TextStyle defaultDayStyle = TectaTypography.body2.copyWith(
              fontWeight: isSelected || isToday ? FontWeight.bold : FontWeight.normal,
              color: dayTextColor,
            );

            final TextStyle resolvedDayTextLabelStyle = isSelected
                ? (widget.selectedDayTextStyle ?? defaultDayStyle)
                : isToday
                    ? (widget.todayTextStyle ?? defaultDayStyle)
                    : isWeekendDay
                        ? (widget.weekendDayTextStyle ?? widget.dayTextStyle ?? defaultDayStyle)
                        : (widget.dayTextStyle ?? defaultDayStyle);

            final dayEvents = widget.events?.where((e) {
              return e.date.year == day.year &&
                  e.date.month == day.month &&
                  e.date.day == day.day;
            }).toList() ?? [];

            return Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: isSelectable ? () => _handleDayTap(day) : null,
                customBorder: const CircleBorder(),
                child: Container(
                  decoration: BoxDecoration(
                    color: dayBgColor,
                    border: dayBorder,
                    borderRadius: dayBorderRadius,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${day.day}',
                        style: resolvedDayTextLabelStyle,
                      ),
                      if (dayEvents.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ...dayEvents.take(3).map((event) => Container(
                                  width: 4,
                                  height: 4,
                                  margin: const EdgeInsets.symmetric(horizontal: 0.75),
                                  decoration: BoxDecoration(
                                    color: isSelected ? Colors.white : event.color,
                                    shape: BoxShape.circle,
                                  ),
                                )),
                            if (dayEvents.length > 3)
                              Padding(
                                padding: const EdgeInsets.only(left: 0.5),
                                child: Text(
                                  '+',
                                  style: TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold,
                                    color: isSelected ? Colors.white : TectaColors.grey500,
                                    height: 1.0,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    ),
  );
}
}
