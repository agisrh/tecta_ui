import 'package:flutter/material.dart';

class SkeletonPlaygroundParser {
  static double parseWidth(String code, double defaultValue) {
    final match = RegExp(r'width:\s*(\d+\.?\d*)').firstMatch(code);
    if (match != null && match.groupCount >= 1) {
      return double.tryParse(match.group(1) ?? '') ?? defaultValue;
    }
    return defaultValue;
  }

  static double parseHeight(String code, double defaultValue) {
    final match = RegExp(r'height:\s*(\d+\.?\d*)').firstMatch(code);
    if (match != null && match.groupCount >= 1) {
      return double.tryParse(match.group(1) ?? '') ?? defaultValue;
    }
    return defaultValue;
  }

  static BoxShape parseShape(String code, BoxShape defaultShape) {
    if (code.contains('BoxShape.circle')) return BoxShape.circle;
    return BoxShape.rectangle;
  }
}
