import 'package:flutter/material.dart';

class TextFieldPlaygroundDocs extends StatelessWidget {
  const TextFieldPlaygroundDocs({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDocRow('label', 'String', 'Floating label description'),
        _buildDocRow('placeholder', 'String', 'Input field background hint'),
        _buildDocRow('helperText', 'String', 'Support detail text under input'),
        _buildDocRow('errorText', 'String', 'Turns on warning mode with custom error label'),
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
