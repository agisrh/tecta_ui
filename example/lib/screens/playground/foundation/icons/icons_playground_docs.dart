import 'package:flutter/material.dart';

class IconsPlaygroundDocs extends StatelessWidget {
  const IconsPlaygroundDocs({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(2),
          1: FlexColumnWidth(3),
        },
        border: TableBorder.all(color: const Color(0xFF333333), width: 0.5),
        children: [
          _buildRow('Icon Name', 'Usage Description', isHeader: true),
          _buildRow('SolarLinearIcons.star', 'Favorite, bookmark, rating indicators'),
          _buildRow('SolarLinearIcons.home', 'Home, dashboard, main landing sections'),
          _buildRow('SolarLinearIcons.settings', 'Settings, configurations, parameters'),
          _buildRow('SolarLinearIcons.user', 'User profile, account details, avatar placeholder'),
          _buildRow('SolarLinearIcons.bell', 'Notifications, alerts, reminders'),
          _buildRow('SolarLinearIcons.calendar', 'Events, dates, schedulers, timelines'),
          _buildRow('SolarLinearIcons.infoCircle', 'Information, helpers, popovers'),
          _buildRow('SolarLinearIcons.checkCircle', 'Success validations, complete states'),
          _buildRow('SolarLinearIcons.letter', 'Mail, inbox, newsletters, message notifications'),
        ],
      ),
    );
  }

  TableRow _buildRow(String col1, String col2, {bool isHeader = false}) {
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
      ],
    );
  }
}
