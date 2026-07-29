import 'package:flutter/material.dart';

class ShadowsPlaygroundDocs extends StatelessWidget {
  const ShadowsPlaygroundDocs({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(2),
          1: FlexColumnWidth(1),
          2: FlexColumnWidth(1),
          3: FlexColumnWidth(3),
        },
        border: TableBorder.all(color: const Color(0xFF333333), width: 0.5),
        children: [
          _buildRow('Property', 'Blur Radius', 'Offset', 'Description', isHeader: true),
          _buildRow('TectaShadows.z1', '4.0', 'Offset(0, 2)', 'Subtle elevation for input fields or tags'),
          _buildRow('TectaShadows.z4', '8.0', 'Offset(0, 4)', 'Low elevation for small cards or buttons'),
          _buildRow('TectaShadows.z8', '16.0', 'Offset(0, 8)', 'Standard elevation for primary cards'),
          _buildRow('TectaShadows.z12', '24.0', 'Offset(0, 12)', 'Medium elevation for dropdowns and popovers'),
          _buildRow('TectaShadows.z16', '32.0', 'Offset(0, 16)', 'Deep elevation for dialogs and sheets'),
          _buildRow('TectaShadows.z20', '40.0', 'Offset(0, 20)', 'High elevation layout overlays'),
          _buildRow('TectaShadows.z24', '48.0', 'Offset(0, 24)', 'Maximum elevation layout overlays'),
        ],
      ),
    );
  }

  TableRow _buildRow(String col1, String col2, String col3, String col4, {bool isHeader = false}) {
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Text(col4, style: style),
        ),
      ],
    );
  }
}
