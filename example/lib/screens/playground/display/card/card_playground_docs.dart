import 'package:flutter/material.dart';

class CardPlaygroundDocs extends StatelessWidget {
  const CardPlaygroundDocs({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDocRow('padding', 'double', 'Spacing inside card padding (e.g. 24.0)'),
        _buildDocRow('header', 'Widget', 'Optional title content or header block'),
        _buildDocRow('content', 'Widget', 'Main body content inside the card'),
        _buildDocRow('actions', 'List<Widget>', 'Footer action buttons/links row'),
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
