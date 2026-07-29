import 'package:flutter/material.dart';

class PickerPlaygroundDocs extends StatelessWidget {
  const PickerPlaygroundDocs({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(2),
          1: FlexColumnWidth(1),
          2: FlexColumnWidth(3),
        },
        border: TableBorder.all(color: const Color(0xFF333333), width: 0.5),
        children: [
          _buildRow('Function', 'Returns', 'Description', isHeader: true),
          _buildRow('showTectaDatePicker', 'Future<DateTime?>', 'Shows a modern date picker dialog box'),
          _buildRow('showTectaTimePicker', 'Future<TimeOfDay?>', 'Shows a premium scroll wheel time picker dialog'),
          _buildRow('showTectaMonthPicker', 'Future<int?>', 'Shows a dialog to pick a calendar month'),
          _buildRow('showTectaYearPicker', 'Future<int?>', 'Shows a dialog to select a calendar year'),
        ],
      ),
    );
  }

  TableRow _buildRow(String col1, String col2, String col3, {bool isHeader = false}) {
    final style = TextStyle(
      fontSize: 12,
      fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
      color: isHeader ? Colors.white : Colors.white70,
    );
    return TableRow(
      decoration: BoxDecoration(
        color: isHeader ? const Color(0xFF222222) : Colors.transparent,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Text(col1, style: style),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Text(col2, style: style),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Text(col3, style: style),
        ),
      ],
    );
  }
}
