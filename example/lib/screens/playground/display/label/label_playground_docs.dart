import 'package:flutter/material.dart';

class LabelPlaygroundDocs extends StatelessWidget {
  const LabelPlaygroundDocs({super.key});

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
          _buildRow('Property', 'Type', 'Description', isHeader: true),
          _buildRow('text', 'String', 'The status label message text'),
          _buildRow('variant', 'TectaLabelVariant', 'Layout variants: filled, outlined, soft (default), inverted'),
          _buildRow('color', 'Color', 'Accent theme color (defaults to primaryMain)'),
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
