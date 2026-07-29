import 'package:flutter/material.dart';

class ButtonPlaygroundDocs extends StatelessWidget {
  const ButtonPlaygroundDocs({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDocRow('label', 'String', 'Button text label'),
        _buildDocRow('variant', 'TectaButtonVariant', 'contained, outlined, soft, text'),
        _buildDocRow('size', 'TectaButtonSize', 'small, medium, large, xLarge'),
        _buildDocRow('loading', 'bool', 'If true, replaces content with spinner'),
        _buildDocRow('hasIcon', 'bool', 'Prepends a mock letter icon inside the action'),
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
