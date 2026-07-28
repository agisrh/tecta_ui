import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

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
      title: 'Meeting Team',
      color: Colors.blue,
      date: DateTime.now(),
    ),
    TectaCalendarEvent(
      id: '2',
      title: 'Cuti Tahunan',
      color: Colors.red,
      date: DateTime.now(),
    ),
    TectaCalendarEvent(
      id: '3',
      title: 'Lembur Kerja',
      color: Colors.green,
      date: DateTime.now(),
    ),
    TectaCalendarEvent(
      id: '4',
      title: 'Overtime Support',
      color: Colors.orange,
      date: DateTime.now(), // 4 events on same day to trigger '+'
    ),
    TectaCalendarEvent(
      id: '5',
      title: 'Libur Nasional',
      color: Colors.red,
      date: DateTime.now().add(const Duration(days: 3)),
    ),
    TectaCalendarEvent(
      id: '6',
      title: 'Weekly Sync',
      color: Colors.purple,
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
  ];

  // Month & Year states
  int _selectedMonth = DateTime.now().month;
  int _selectedYear = DateTime.now().year;

  // Time states
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
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: MediaQuery.of(context).size.width >= 1024 ? null : AppBar(
          title: Text(
            'Calendar & Pickers',
            style: TectaTypography.h4.copyWith(color: TectaColors.grey800),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(56.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              child: Container(
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  color: TectaColors.grey200,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TabBar(
                  labelColor: TectaColors.grey900,
                  unselectedLabelColor: TectaColors.grey500,
                  labelStyle: TectaTypography.subtitle2.copyWith(fontWeight: FontWeight.w600),
                  unselectedLabelStyle: TectaTypography.subtitle2.copyWith(fontWeight: FontWeight.w500),
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  indicator: BoxDecoration(
                    color: TectaColors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: TectaShadows.z1,
                  ),
                  tabs: const [
                    Tab(text: 'Date / Calendar'),
                    Tab(text: 'Month / Year'),
                    Tab(text: 'Time'),
                  ],
                ),
              ),
            ),
          ),
        ),
        backgroundColor: TectaColors.grey100,
        body: TabBarView(
          children: [
            _buildCalendarTab(),
            _buildMonthYearTab(),
            _buildTimeTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarTab() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
      children: [
        _buildSectionHeader('INLINE CALENDAR (SINGLE SELECT)'),
        const SizedBox(height: 16),
        _buildCard(
          child: Column(
            children: [
              TectaCalendar(
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
            ],
          ),
        ),
        const SizedBox(height: 32),
        _buildSectionHeader('LOCALIZED CALENDAR (INDONESIAN WEEKDAYS)'),
        const SizedBox(height: 16),
        _buildCard(
          child: TectaCalendar(
            selectedDate: _selectedDate,
            weekdays: const ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'],
            monthNames: const [
              'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
              'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
            ],
            weekendHeaderTextStyle: const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            weekendDayTextStyle: const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
            onDateSelected: (date) {
              setState(() {
                _selectedDate = date;
              });
              _showFeedback('Selected: ${date.toLocal().toString().split(' ')[0]}');
            },
          ),
        ),
        const SizedBox(height: 32),

        _buildSectionHeader('INLINE CALENDAR (RANGE SELECT)'),
        const SizedBox(height: 16),
        _buildCard(
          child: Column(
            children: [
              TectaCalendar(
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
                    _showFeedback('Selected range: ${start.day} - ${end.day}');
                  }
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),

        _buildSectionHeader('PICKER DIALOG POPUPS'),
        const SizedBox(height: 16),
        _buildCard(
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
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
                    _showFeedback('Dialog Selected: $date');
                  }
                },
              ),
              TectaButton(
                label: 'Show Range Picker (Purple Custom)',
                color: Colors.purple,
                onPressed: () async {
                  final range = await showTectaDateRangePicker(
                    context: context,
                    initialStartDate: _rangeStart,
                    initialEndDate: _rangeEnd,
                    selectedColor: Colors.purple,
                    rangeColor: Colors.purple.withValues(alpha: 0.15),
                    confirmButton: TectaButton(
                      label: 'Save Range',
                      color: Colors.purple,
                      onPressed: () {}, // Handled by dialog helper default pop behavior but allows widget overriding
                    ),
                  );
                  if (range != null) {
                    setState(() {
                      _rangeStart = range.start;
                      _rangeEnd = range.end;
                    });
                    _showFeedback('Dialog Selected Range: ${range.start} - ${range.end}');
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMonthYearTab() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
      children: [
        _buildSectionHeader('INLINE MONTH PICKER'),
        const SizedBox(height: 16),
        _buildCard(
          child: TectaMonthPicker(
            selectedMonth: _selectedMonth,
            onMonthSelected: (month) {
              setState(() => _selectedMonth = month);
              _showFeedback('Month: $month');
            },
          ),
        ),
        const SizedBox(height: 32),

        _buildSectionHeader('INLINE YEAR PICKER'),
        const SizedBox(height: 16),
        _buildCard(
          child: TectaYearPicker(
            selectedYear: _selectedYear,
            onYearSelected: (year) {
              setState(() => _selectedYear = year);
              _showFeedback('Year: $year');
            },
          ),
        ),
        const SizedBox(height: 32),

        _buildSectionHeader('MONTH & YEAR DIALOG POPUPS'),
        const SizedBox(height: 16),
        _buildCard(
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              TectaButton(
                label: 'Show Month Picker',
                onPressed: () async {
                  final month = await showTectaMonthPicker(
                    context: context,
                    initialMonth: _selectedMonth,
                  );
                  if (month != null) {
                    setState(() => _selectedMonth = month);
                    _showFeedback('Month Dialog Selected: $month');
                  }
                },
              ),
              TectaButton(
                label: 'Show Year Picker (Teal Custom)',
                color: Colors.teal,
                onPressed: () async {
                  final year = await showTectaYearPicker(
                    context: context,
                    initialYear: _selectedYear,
                    selectedColor: Colors.teal,
                  );
                  if (year != null) {
                    setState(() => _selectedYear = year);
                    _showFeedback('Year Dialog Selected: $year');
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTimeTab() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
      children: [
        _buildSectionHeader('INLINE TIME PICKER (24H FORMAT)'),
        const SizedBox(height: 16),
        _buildCard(
          child: Column(
            children: [
              Text(
                'Selected: ${_selectedTime.format(context)}',
                style: TectaTypography.subtitle1.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TectaTimePicker(
                initialTime: _selectedTime,
                format: TectaTimeFormat.h24,
                onTimeChanged: (time) {
                  setState(() => _selectedTime = time);
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),

        _buildSectionHeader('INLINE TIME PICKER (12H FORMAT + ORANGE CUSTOM)'),
        const SizedBox(height: 16),
        _buildCard(
          child: Column(
            children: [
              Text(
                'Selected: ${_selectedTime12h.format(context)}',
                style: TectaTypography.subtitle1.copyWith(fontWeight: FontWeight.bold, color: Colors.orange),
              ),
              const SizedBox(height: 16),
              TectaTimePicker(
                initialTime: _selectedTime12h,
                format: TectaTimeFormat.h12,
                activeColor: Colors.orange,
                onTimeChanged: (time) {
                  setState(() => _selectedTime12h = time);
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),

        _buildSectionHeader('INLINE DIAL CLOCK FACE (12H FORMAT + PURPLE CUSTOM)'),
        const SizedBox(height: 16),
        _buildCard(
          child: Column(
            children: [
              Text(
                'Selected Dial: ${_selectedTime12h.format(context)}',
                style: TectaTypography.subtitle1.copyWith(fontWeight: FontWeight.bold, color: Colors.purple),
              ),
              const SizedBox(height: 16),
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
        ),
        const SizedBox(height: 32),

        _buildSectionHeader('TIME DIALOG POPUPS'),
        const SizedBox(height: 16),
        _buildCard(
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              TectaButton(
                label: 'Show Time Picker Dialog (Wheel)',
                onPressed: () async {
                  final time = await showTectaTimePicker(
                    context: context,
                    initialTime: _selectedTime,
                    style: TectaTimePickerStyle.wheel,
                  );
                  if (time != null) {
                    if (!mounted) return;
                    setState(() => _selectedTime = time);
                    _showFeedback('Time Dialog Selected: ${time.format(context)}');
                  }
                },
              ),
              TectaButton(
                label: 'Show Time Picker Dialog (Dial)',
                color: Colors.purple,
                onPressed: () async {
                  final time = await showTectaTimePicker(
                    context: context,
                    initialTime: _selectedTime,
                    style: TectaTimePickerStyle.dial,
                    activeColor: Colors.purple,
                  );
                  if (time != null) {
                    if (!mounted) return;
                    setState(() => _selectedTime = time);
                    _showFeedback('Time Dialog Selected: ${time.format(context)}');
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Text(
        title,
        style: TectaTypography.overline.copyWith(
          color: TectaColors.grey500,
          fontSize: 12,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 28.0),
      decoration: BoxDecoration(
        color: TectaColors.white,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: TectaColors.grey200),
      ),
      child: child,
    );
  }
}
