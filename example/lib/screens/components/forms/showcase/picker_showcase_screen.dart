import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';
import '../../../../utils/showcase_page_layout.dart';
import '../../../../utils/showcase_section.dart';

class PickerShowcasePage extends StatefulWidget {
  const PickerShowcasePage({super.key});

  @override
  State<PickerShowcasePage> createState() => _PickerShowcasePageState();
}

class _PickerShowcasePageState extends State<PickerShowcasePage> {
  // Calendar states
  DateTime? _selectedDate = DateTime.now();
  DateTime? _rangeStart = DateTime.now();
  DateTime? _rangeEnd = DateTime.now().add(const Duration(days: 5));

  late final List<TectaCalendarEvent> _mockEvents = [
    TectaCalendarEvent(
      id: '1',
      title: 'Team Meeting',
      color: Colors.blue,
      date: DateTime.now(),
    ),
    TectaCalendarEvent(
      id: '2',
      title: 'Annual Leave',
      color: Colors.red,
      date: DateTime.now(),
    ),
    TectaCalendarEvent(
      id: '3',
      title: 'Overtime Sync',
      color: Colors.green,
      date: DateTime.now(),
    ),
    TectaCalendarEvent(
      id: '4',
      title: 'Support Shift',
      color: Colors.orange,
      date: DateTime.now(),
    ),
  ];

  int _selectedMonth = DateTime.now().month;
  int _selectedYear = DateTime.now().year;

  TimeOfDay _selectedTime = const TimeOfDay(hour: 10, minute: 30);
  TimeOfDay _selectedTime12h = const TimeOfDay(hour: 14, minute: 45);

  void _showFeedback(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: MediaQuery.of(context).size.width >= 1024
          ? null
          : AppBar(
              title: Text(
                'DatePicker & TimePicker',
                style: TectaTypography.h4.copyWith(
                  color: isDark ? Colors.white : TectaColors.grey800,
                ),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(1.0),
                child: Container(
                  color: theme.dividerColor,
                  height: 1.0,
                ),
              ),
            ),
      body: ShowcasePageLayout(
        sections: [
          ShowcaseSection(
            title: 'Inline Calendar (Single Select)',
            note: 'TectaCalendar provides a full monthly grid view supporting events, customized highlight styles, and single date selection.',
            code: '''TectaCalendar(
  selectedDate: _selectedDate,
  selectionMode: TectaCalendarSelectionMode.single,
  events: _mockEvents,
  onDateSelected: (date) {
    setState(() => _selectedDate = date);
  },
)''',
            overview: SizedBox(
              width: 400,
              child: TectaCalendar(
                selectedDate: _selectedDate,
                selectionMode: TectaCalendarSelectionMode.single,
                events: _mockEvents,
                onDateSelected: (date) {
                  setState(() {
                    _selectedDate = date;
                  });
                  _showFeedback('Selected: ${date.toLocal().toString().split(' ')[0]}');
                },
              ),
            ),
          ),
          ShowcaseSection(
            title: 'Inline Calendar (Range Select)',
            note: 'Enable range selection to pick start and end dates with custom highlight colors between selection thresholds.',
            code: '''TectaCalendar(
  rangeStartDate: _rangeStart,
  rangeEndDate: _rangeEnd,
  selectionMode: TectaCalendarSelectionMode.range,
  selectedColor: Colors.purple,
  rangeColor: Colors.purple.withValues(alpha: 0.12),
  onRangeSelected: (start, end) {
    setState(() {
      _rangeStart = start;
      _rangeEnd = end;
    });
  },
)''',
            overview: SizedBox(
              width: 400,
              child: TectaCalendar(
                rangeStartDate: _rangeStart,
                rangeEndDate: _rangeEnd,
                selectionMode: TectaCalendarSelectionMode.range,
                selectedColor: Colors.purple,
                rangeColor: Colors.purple.withValues(alpha: 0.12),
                onRangeSelected: (start, end) {
                  setState(() {
                    _rangeStart = start;
                    _rangeEnd = end;
                  });
                  if (start != null && end != null) {
                    _showFeedback('Range: ${start.day} - ${end.day}');
                  }
                },
              ),
            ),
          ),
          ShowcaseSection(
            title: 'Month & Year Pickers',
            note: 'Compact inline selectors for month-only or year-only configurations, helpful for filters or analytical views.',
            code: '''TectaMonthPicker(
  selectedMonth: _selectedMonth,
  onMonthSelected: (month) => setState(() => _selectedMonth = month),
)

TectaYearPicker(
  selectedYear: _selectedYear,
  onYearSelected: (year) => setState(() => _selectedYear = year),
)''',
            overview: Wrap(
              spacing: 32,
              runSpacing: 24,
              children: [
                SizedBox(
                  width: 320,
                  child: TectaMonthPicker(
                    selectedMonth: _selectedMonth,
                    onMonthSelected: (month) {
                      setState(() => _selectedMonth = month);
                      _showFeedback('Month: $month');
                    },
                  ),
                ),
                SizedBox(
                  width: 320,
                  child: TectaYearPicker(
                    selectedYear: _selectedYear,
                    onYearSelected: (year) {
                      setState(() => _selectedYear = year);
                      _showFeedback('Year: $year');
                    },
                  ),
                ),
              ],
            ),
          ),
          ShowcaseSection(
            title: 'Time Pickers (Wheel vs Dial)',
            note: 'TectaTimePicker supports both 24-hour and 12-hour AM/PM formats, with picker styles in Wheel (default scroll list) or Dial (clock face selector).',
            code: '''// Wheel style (24h)
TectaTimePicker(
  initialTime: _time,
  format: TectaTimeFormat.h24,
  onTimeChanged: (time) => setState(() => _time = time),
)

// Dial style (12h)
TectaTimePicker(
  initialTime: _time12h,
  format: TectaTimeFormat.h12,
  style: TectaTimePickerStyle.dial,
  activeColor: Colors.purple,
  onTimeChanged: (time) => setState(() => _time12h = time),
)''',
            overview: Wrap(
              spacing: 40,
              runSpacing: 24,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Wheel (24H): ${_selectedTime.format(context)}', style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    TectaTimePicker(
                      initialTime: _selectedTime,
                      format: TectaTimeFormat.h24,
                      onTimeChanged: (time) {
                        setState(() => _selectedTime = time);
                      },
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Dial (12H): ${_selectedTime12h.format(context)}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.purple)),
                    const SizedBox(height: 12),
                    TectaTimePicker(
                      initialTime: _selectedTime12h,
                      format: TectaTimeFormat.h12,
                      style: TectaTimePickerStyle.dial,
                      activeColor: Colors.purple,
                      onTimeChanged: (time) {
                        setState(() => _selectedTime12h = time);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          ShowcaseSection(
            title: 'Dialog Pickers',
            note: 'Invoke date, date-range, and time pickers inside premium dialog overlays helper methods.',
            code: '''// Show Date dialog
final date = await showTectaDatePicker(
  context: context,
  initialDate: DateTime.now(),
  firstDate: DateTime.now().subtract(Duration(days: 365)),
  lastDate: DateTime.now().add(Duration(days: 365)),
);

// Show Time dialog
final time = await showTectaTimePicker(
  context: context,
  initialTime: TimeOfDay.now(),
  style: TectaTimePickerStyle.wheel,
);''',
            overview: Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                TectaButton(
                  label: 'Show Date Picker',
                  onPressed: () async {
                    final date = await showTectaDatePicker(
                      context: context,
                      initialDate: _selectedDate ?? DateTime.now(),
                      firstDate: DateTime.now().subtract(const Duration(days: 365)),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (date != null) {
                      setState(() => _selectedDate = date);
                      _showFeedback('Selected: $date');
                    }
                  },
                ),
                TectaButton(
                  label: 'Show Date Range Picker',
                  color: Colors.purple,
                  onPressed: () async {
                    final range = await showTectaDateRangePicker(
                      context: context,
                      initialStartDate: _rangeStart,
                      initialEndDate: _rangeEnd,
                      selectedColor: Colors.purple,
                      rangeColor: Colors.purple.withValues(alpha: 0.15),
                    );
                    if (range != null) {
                      setState(() {
                        _rangeStart = range.start;
                        _rangeEnd = range.end;
                      });
                      _showFeedback('Range Selected: ${range.start} - ${range.end}');
                    }
                  },
                ),
                TectaButton(
                  label: 'Show Time Picker',
                  color: TectaColors.successMain,
                  onPressed: () async {
                    final time = await showTectaTimePicker(
                      context: context,
                      initialTime: _selectedTime,
                    );
                    if (time != null && context.mounted) {
                      setState(() => _selectedTime = time);
                      _showFeedback('Time Selected: ${time.format(context)}');
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
