import 'package:flutter/material.dart';
import 'playground/foundation/colors/colors_playground.dart';
import 'playground/display/card/card_playground.dart';
import 'playground/forms/button/button_playground.dart';
import 'playground/feedback/alert/alert_playground.dart';
import 'playground/forms/text_field/text_field_playground.dart';

class PlaygroundTabScreen extends StatefulWidget {
  const PlaygroundTabScreen({super.key});

  @override
  State<PlaygroundTabScreen> createState() => _PlaygroundTabScreenState();
}

class _PlaygroundTabScreenState extends State<PlaygroundTabScreen> {
  String _selectedTemplate = 'Color';

  void _onTemplateChanged(String template) {
    setState(() {
      _selectedTemplate = template;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_selectedTemplate == 'Color') {
      return ColorsPlayground(onTemplateChanged: _onTemplateChanged);
    } else if (_selectedTemplate == 'Card') {
      return CardPlayground(onTemplateChanged: _onTemplateChanged);
    } else if (_selectedTemplate == 'Button') {
      return ButtonPlayground(onTemplateChanged: _onTemplateChanged);
    } else if (_selectedTemplate == 'Alert') {
      return AlertPlayground(onTemplateChanged: _onTemplateChanged);
    } else if (_selectedTemplate == 'TextField') {
      return TextFieldPlayground(onTemplateChanged: _onTemplateChanged);
    }

    // Dynamic fallback widget for other modules/placeholder
    return Scaffold(
      backgroundColor: const Color(0xFF161616),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.code, color: Color(0xFFFF8C42), size: 48),
              const SizedBox(height: 12),
              Text(
                '$_selectedTemplate Playground',
                style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'This component does not have an active playground module yet.',
                style: TextStyle(fontSize: 12, color: Colors.white54),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
