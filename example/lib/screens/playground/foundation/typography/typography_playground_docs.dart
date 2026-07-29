import 'package:flutter/material.dart';

class TypographyPlaygroundDocs extends StatelessWidget {
  const TypographyPlaygroundDocs({super.key});

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
          _buildRow('Property', 'Font Size', 'Weight', 'Description', isHeader: true),
          _buildRow('TectaTypography.h1', '32.0', 'Bold', 'Main heading style'),
          _buildRow('TectaTypography.h2', '28.0', 'Bold', 'Section title style'),
          _buildRow('TectaTypography.h3', '24.0', 'Bold', 'Subsection heading style'),
          _buildRow('TectaTypography.h4', '20.0', 'SemiBold', 'Content header style'),
          _buildRow('TectaTypography.h5', '16.0', 'SemiBold', 'Small section header'),
          _buildRow('TectaTypography.h6', '14.0', 'Medium', 'Detailed caption header'),
          _buildRow('TectaTypography.subtitle1', '16.0', 'Medium', 'Prominent subtitle text'),
          _buildRow('TectaTypography.subtitle2', '14.0', 'Medium', 'Secondary subtitle text'),
          _buildRow('TectaTypography.body1', '16.0', 'Regular', 'Primary body copy text'),
          _buildRow('TectaTypography.body2', '14.0', 'Regular', 'Secondary small body copy'),
          _buildRow('TectaTypography.caption', '12.0', 'Regular', 'Small label or helper text'),
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
