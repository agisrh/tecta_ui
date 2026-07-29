import 'package:flutter/material.dart';

class AlertPlaygroundDocs extends StatelessWidget {
  const AlertPlaygroundDocs({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDocRow('title', 'String', 'Main header title'),
        _buildDocRow('message', 'String', 'Description content inside warning'),
        _buildDocRow('severity', 'TectaAlertSeverity', 'info, success, warning, error'),
        _buildDocRow('variant', 'TectaAlertVariant', 'soft, border, solid'),
        _buildDocRow('isClosable', 'bool', 'Appends close button to header if enabled'),
      ],
    );
  }

  Widget _buildDocRow(String param, String type, String desc) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              param,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: Color(0xFF9CDCFE),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: 130,
            child: Text(
              type,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                color: Color(0xFF4EC9B0),
              ),
            ),
          ),
          Expanded(
            child: Text(
              desc,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white70,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
