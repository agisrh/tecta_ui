import 'package:flutter/material.dart';

/// Data model representing an event to be displayed on [TectaCalendar].
class TectaCalendarEvent {
  /// Unique identifier of the event.
  final String id;

  /// Title or short description of the event.
  final String title;

  /// Visual representation color of the event.
  final Color color;

  /// Target date of the event.
  final DateTime date;

  const TectaCalendarEvent({
    required this.id,
    required this.title,
    required this.color,
    required this.date,
  });
}
