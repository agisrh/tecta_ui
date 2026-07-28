import 'package:flutter/material.dart';

class ColorsPlaygroundDocs extends StatelessWidget {
  const ColorsPlaygroundDocs({super.key});

  Widget _buildDocHeader() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          SizedBox(
            width: 140,
            child: Text(
              'Parameter',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white38),
            ),
          ),
          SizedBox(
            width: 80,
            child: Text(
              'Type',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white38),
            ),
          ),
          Expanded(
            child: Text(
              'Description / Allowed Values',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white38),
            ),
          ),
        ],
      ),
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
            width: 80,
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
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDocHeader(),
        const Divider(color: Color(0xFF2D2D2D), height: 1),
        const SizedBox(height: 8),
        _buildDocRow('width', 'double', 'Width of the preview container. (e.g. 200)'),
        _buildDocRow('height', 'double', 'Height of the preview container. (e.g. 200)'),
        _buildDocRow('borderRadius', 'double', 'Radius of corners via BorderRadius.circular(R). (e.g. 16)'),
        _buildDocRow('TectaColors.<name>', 'Color', 'Tecta palette colors: primaryMain, secondaryMain, successMain, warningMain, errorMain, infoMain (plus Light/Lighter/Dark/Darker variants).'),
      ],
    );
  }
}
