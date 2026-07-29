// ignore_for_file: prefer_adjacent_string_concatenation

import 'package:flutter/material.dart';

/// A custom TextEditingController to highlight Dart/Flutter code syntax dynamically.
class CodePlaygroundController extends TextEditingController {
  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    final List<TextSpan> children = [];
    final textVal = text;

    // A basic Dart syntax highlighter using Regex
    final regExp = RegExp(
      r'\b(import|class|extends|final|const|return|Widget|build|BuildContext|context|void|null|true|false|super)\b|' // Keywords [1]
      r'\b(TectaCard|TectaButton|TectaAlert|TectaTextField|Text|Padding|Row|Column|EdgeInsets|TextStyle|Divider|Container|BoxDecoration|BorderRadius)\b|' // Widget/Class names [2]
      r'([a-zA-Z0-9_-]+)(?=\:)|' // Parameters/Key arguments [3]
      r'(".*?"|' +
          "'.*?')" +
          r'|' // Strings [4]
      r'(\b\d+\b)', // Numbers [5]
    );

    int lastMatchEnd = 0;

    regExp.allMatches(textVal).forEach((match) {
      if (match.start > lastMatchEnd) {
        children.add(TextSpan(text: textVal.substring(lastMatchEnd, match.start)));
      }

      if (match.group(1) != null) {
        // Keywords
        children.add(TextSpan(
          text: match.group(0),
          style: const TextStyle(color: Color(0xFFC586C0), fontWeight: FontWeight.bold),
        ));
      } else if (match.group(2) != null) {
        // Widgets/Classes
        children.add(TextSpan(
          text: match.group(0),
          style: const TextStyle(color: Color(0xFF4EC9B0)),
        ));
      } else if (match.group(3) != null) {
        // Params (e.g. padding:)
        children.add(TextSpan(
          text: match.group(0),
          style: const TextStyle(color: Color(0xFF9CDCFE)),
        ));
      } else if (match.group(4) != null) {
        // Strings
        children.add(TextSpan(
          text: match.group(0),
          style: const TextStyle(color: Color(0xFFCE9178)),
        ));
      } else if (match.group(5) != null) {
        // Numbers
        children.add(TextSpan(
          text: match.group(0),
          style: const TextStyle(color: Color(0xFFB5CEA8)),
        ));
      } else {
        children.add(TextSpan(text: match.group(0)));
      }

      lastMatchEnd = match.end;
    });

    if (lastMatchEnd < textVal.length) {
      children.add(TextSpan(text: textVal.substring(lastMatchEnd)));
    }

    return TextSpan(style: style, children: children);
  }
}
