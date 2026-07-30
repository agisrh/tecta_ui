import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

/// Time format for [TectaTimePicker].
enum TectaTimeFormat {
  /// 12 Hour format (with AM/PM).
  h12,
  /// 24 Hour format.
  h24
}

/// Visual style variants for [TectaTimePicker].
enum TectaTimePickerStyle {
  /// Scroll wheel spinner (iOS-style).
  wheel,
  /// Circular clock face dial (Material-style).
  dial
}

/// A premium, highly customizable Time Picker component for the Tecta Design System.
class TectaTimePicker extends StatefulWidget {
  /// The initial selected time of day.
  final TimeOfDay initialTime;

  /// Callback when the time is selected/changed.
  final ValueChanged<TimeOfDay> onTimeChanged;

  /// Time format (12h or 24h). Defaults to [TectaTimeFormat.h24].
  final TectaTimeFormat format;

  /// The visual picker style. Defaults to [TectaTimePickerStyle.wheel].
  final TectaTimePickerStyle style;

  /// Custom active color for highlighted elements.
  final Color? activeColor;

  /// Custom text style for selected/unselected time numbers.
  final TextStyle? timeTextStyle;

  /// Custom text style for AM/PM label.
  final TextStyle? ampmTextStyle;

  const TectaTimePicker({
    super.key,
    required this.initialTime,
    required this.onTimeChanged,
    this.format = TectaTimeFormat.h24,
    this.style = TectaTimePickerStyle.wheel,
    this.activeColor,
    this.timeTextStyle,
    this.ampmTextStyle,
  });

  @override
  State<TectaTimePicker> createState() => _TectaTimePickerState();
}

class _TectaTimePickerState extends State<TectaTimePicker> {
  // Wheel State
  late FixedExtentScrollController _hourController;
  late FixedExtentScrollController _minuteController;
  late FixedExtentScrollController _ampmController;

  // Dial State
  bool _isSelectingHours = true; // true = hours, false = minutes

  late int _selectedHour;
  late int _selectedMinute;
  late bool _isAm;

  @override
  void initState() {
    super.initState();
    final hour = widget.initialTime.hour;
    _selectedMinute = widget.initialTime.minute;

    if (widget.format == TectaTimeFormat.h12) {
      _isAm = hour < 12;
      _selectedHour = hour % 12;
      if (_selectedHour == 0) _selectedHour = 12;
    } else {
      _selectedHour = hour;
      _isAm = true;
    }

    final hourIndex = widget.format == TectaTimeFormat.h12
        ? _selectedHour - 1
        : _selectedHour;

    _hourController = FixedExtentScrollController(initialItem: hourIndex);
    _minuteController = FixedExtentScrollController(initialItem: _selectedMinute);
    _ampmController = FixedExtentScrollController(initialItem: _isAm ? 0 : 1);
  }

  void _notifyChange() {
    int finalHour = _selectedHour;
    if (widget.format == TectaTimeFormat.h12) {
      if (_isAm) {
        if (finalHour == 12) finalHour = 0;
      } else {
        if (finalHour != 12) finalHour += 12;
      }
    }
    widget.onTimeChanged(TimeOfDay(hour: finalHour, minute: _selectedMinute));
  }

  @override
  Widget build(BuildContext context) {
    if (widget.style == TectaTimePickerStyle.dial) {
      return _buildDialPicker(context);
    }
    return _buildWheelPicker(context);
  }

  Widget _buildWheelPicker(BuildContext context) {
    final activeThemeColor = widget.activeColor ?? Theme.of(context).colorScheme.primary;
    final resolvedActive = TectaColors.resolve(context, activeThemeColor);
    final totalHours = widget.format == TectaTimeFormat.h12 ? 12 : 24;

    final TextStyle textStyle = widget.timeTextStyle ??
        TectaTypography.h4.copyWith(
          color: TectaColors.grey800,
          fontWeight: FontWeight.bold,
        );

    final double itemHeight = 48.0;

    return SizedBox(
      height: 180,
      child: Stack(
        children: [
          Center(
            child: Container(
              height: itemHeight,
              decoration: BoxDecoration(
                color: resolvedActive.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ListWheelScrollView.useDelegate(
                  controller: _hourController,
                  itemExtent: itemHeight,
                  perspective: 0.005,
                  diameterRatio: 1.2,
                  physics: const FixedExtentScrollPhysics(),
                  onSelectedItemChanged: (index) {
                    setState(() {
                      _selectedHour = widget.format == TectaTimeFormat.h12
                          ? index + 1
                          : index;
                    });
                    _notifyChange();
                  },
                  childDelegate: ListWheelChildBuilderDelegate(
                    builder: (context, index) {
                      if (index < 0 || index >= totalHours) return null;
                      final hourVal = widget.format == TectaTimeFormat.h12
                          ? index + 1
                          : index;
                      final isSelected = _selectedHour == hourVal;

                      return Center(
                        child: Text(
                          hourVal.toString().padLeft(2, '0'),
                          style: textStyle.copyWith(
                            color: isSelected ? resolvedActive : TectaColors.grey400,
                          ),
                        ),
                      );
                    },
                    childCount: totalHours,
                  ),
                ),
              ),
              Text(':', style: textStyle.copyWith(color: TectaColors.grey500)),
              Expanded(
                child: ListWheelScrollView.useDelegate(
                  controller: _minuteController,
                  itemExtent: itemHeight,
                  perspective: 0.005,
                  diameterRatio: 1.2,
                  physics: const FixedExtentScrollPhysics(),
                  onSelectedItemChanged: (index) {
                    setState(() {
                      _selectedMinute = index;
                    });
                    _notifyChange();
                  },
                  childDelegate: ListWheelChildBuilderDelegate(
                    builder: (context, index) {
                      if (index < 0 || index >= 60) return null;
                      final isSelected = _selectedMinute == index;
                      return Center(
                        child: Text(
                          index.toString().padLeft(2, '0'),
                          style: textStyle.copyWith(
                            color: isSelected ? resolvedActive : TectaColors.grey400,
                          ),
                        ),
                      );
                    },
                    childCount: 60,
                  ),
                ),
              ),
              if (widget.format == TectaTimeFormat.h12) ...[
                const SizedBox(width: 8),
                Expanded(
                  child: ListWheelScrollView.useDelegate(
                    controller: _ampmController,
                    itemExtent: itemHeight,
                    perspective: 0.005,
                    diameterRatio: 1.2,
                    physics: const FixedExtentScrollPhysics(),
                    onSelectedItemChanged: (index) {
                      setState(() {
                        _isAm = index == 0;
                      });
                      _notifyChange();
                    },
                    childDelegate: ListWheelChildBuilderDelegate(
                      builder: (context, index) {
                        if (index < 0 || index >= 2) return null;
                        final isAmOption = index == 0;
                        final label = isAmOption ? 'AM' : 'PM';
                        final isSelected = _isAm == isAmOption;

                        return Center(
                          child: Text(
                            label,
                            style: (widget.ampmTextStyle ?? textStyle).copyWith(
                              fontSize: 20.0,
                              color: isSelected ? resolvedActive : TectaColors.grey400,
                            ),
                          ),
                        );
                      },
                      childCount: 2,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDialPicker(BuildContext context) {
    final activeThemeColor = widget.activeColor ?? Theme.of(context).colorScheme.primary;
    final resolvedActive = TectaColors.resolve(context, activeThemeColor);

    final String hourStr = _selectedHour.toString().padLeft(2, '0');
    final String minuteStr = _selectedMinute.toString().padLeft(2, '0');

    final displayStyle = widget.timeTextStyle ??
        TectaTypography.h2.copyWith(fontWeight: FontWeight.bold);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Digital Header Selector
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => setState(() => _isSelectingHours = true),
              child: Text(
                hourStr,
                style: displayStyle.copyWith(
                  color: _isSelectingHours ? resolvedActive : TectaColors.grey400,
                ),
              ),
            ),
            Text(
              ' : ',
              style: displayStyle.copyWith(color: TectaColors.grey400),
            ),
            GestureDetector(
              onTap: () => setState(() => _isSelectingHours = false),
              child: Text(
                minuteStr,
                style: displayStyle.copyWith(
                  color: !_isSelectingHours ? resolvedActive : TectaColors.grey400,
                ),
              ),
            ),
            if (widget.format == TectaTimeFormat.h12) ...[
              const SizedBox(width: 12),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() => _isAm = true);
                      _notifyChange();
                    },
                    child: Text(
                      'AM',
                      style: (widget.ampmTextStyle ?? TectaTypography.subtitle2).copyWith(
                        color: _isAm ? resolvedActive : TectaColors.grey400,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  GestureDetector(
                    onTap: () {
                      setState(() => _isAm = false);
                      _notifyChange();
                    },
                    child: Text(
                      'PM',
                      style: (widget.ampmTextStyle ?? TectaTypography.subtitle2).copyWith(
                        color: !_isAm ? resolvedActive : TectaColors.grey400,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
        const SizedBox(height: 24),
        // Dial Face Widget
        LayoutBuilder(
          builder: (context, constraints) {
            final double size = min(constraints.maxWidth, 240.0);
            return SizedBox(
              width: size,
              height: size,
              child: GestureDetector(
                onPanUpdate: (details) => _handleDialInput(details.localPosition, size),
                onPanDown: (details) => _handleDialInput(details.localPosition, size),
                child: CustomPaint(
                  size: Size(size, size),
                  painter: _DialPainter(
                    isSelectingHours: _isSelectingHours,
                    selectedValue: _isSelectingHours ? _selectedHour : _selectedMinute,
                    format: widget.format,
                    activeColor: resolvedActive,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  void _handleDialInput(Offset localPosition, double dialSize) {
    final center = Offset(dialSize / 2, dialSize / 2);
    final dx = localPosition.dx - center.dx;
    final dy = localPosition.dy - center.dy;

    // Angle calculation (0 at 3 o'clock)
    double angle = atan2(dy, dx);
    // Align so 0 is at 12 o'clock
    double finalAngle = angle + pi / 2;
    if (finalAngle < 0) finalAngle += 2 * pi;

    if (_isSelectingHours) {
      if (widget.format == TectaTimeFormat.h12) {
        int hour = (finalAngle / (2 * pi / 12)).round();
        if (hour == 0) hour = 12;
        setState(() {
          _selectedHour = hour;
        });
      } else {
        // 24 Hour format: Check distance to decide inner or outer circle
        final r = sqrt(dx * dx + dy * dy);
        final R = dialSize / 2;
        int hour;

        if (r < R * 0.65) {
          // Inner Circle (13 to 24/00)
          hour = (finalAngle / (2 * pi / 12)).round() + 12;
          if (hour == 24) hour = 0;
        } else {
          // Outer Circle (1 to 12)
          hour = (finalAngle / (2 * pi / 12)).round();
          if (hour == 0) hour = 12;
        }
        setState(() {
          _selectedHour = hour;
        });
      }
    } else {
      // Minutes Selection (0 to 59)
      int minute = (finalAngle / (2 * pi / 60)).round();
      if (minute == 60) minute = 0;
      setState(() {
        _selectedMinute = minute;
      });
    }
    _notifyChange();
  }

  @override
  void dispose() {
    _hourController.dispose();
    _minuteController.dispose();
    _ampmController.dispose();
    super.dispose();
  }
}

class _DialPainter extends CustomPainter {
  final bool isSelectingHours;
  final int selectedValue;
  final TectaTimeFormat format;
  final Color activeColor;

  _DialPainter({
    required this.isSelectingHours,
    required this.selectedValue,
    required this.format,
    required this.activeColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Draw clock face background
    final paint = Paint()
      ..color = TectaColors.grey100
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, paint);

    // Draw center point pin
    paint.color = activeColor;
    canvas.drawCircle(center, 4.0, paint);

    final double activeRadius;
    final double angle;

    if (isSelectingHours) {
      final int hour = selectedValue;
      final bool isInner = format == TectaTimeFormat.h24 && (hour > 12 || hour == 0);
      activeRadius = isInner ? radius * 0.5 : radius * 0.8;
      
      // 12 sectors on clock dial
      final int sector = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
      angle = (sector * 30 - 90) * pi / 180;
    } else {
      activeRadius = radius * 0.8;
      // 60 sectors on clock dial
      angle = (selectedValue * 6 - 90) * pi / 180;
    }

    // Draw Jarum/Hand line
    final handEnd = Offset(
      center.dx + activeRadius * cos(angle),
      center.dy + activeRadius * sin(angle),
    );

    final linePaint = Paint()
      ..color = activeColor
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
    canvas.drawLine(center, handEnd, linePaint);

    // Draw selected day active circle indicator
    paint.color = activeColor;
    canvas.drawCircle(handEnd, 16.0, paint);



    if (isSelectingHours) {
      if (format == TectaTimeFormat.h12) {
        _drawLabels(canvas, center, radius * 0.8, 12, (i) => i == 0 ? 12 : i);
      } else {
        // Outer ring: 1-12
        _drawLabels(canvas, center, radius * 0.8, 12, (i) => i == 0 ? 12 : i);
        // Inner ring: 13-00
        _drawLabels(canvas, center, radius * 0.5, 12, (i) => i == 0 ? 0 : i + 12);
      }
    } else {
      // Minutes Labels (every 5 minutes: 0, 5, 10, 15...)
      _drawLabels(canvas, center, radius * 0.8, 12, (i) => (i * 5) % 60);
    }
  }

  void _drawLabels(
    Canvas canvas,
    Offset center,
    double radius,
    int count,
    int Function(int) valueForIndex,
  ) {
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    for (int i = 0; i < count; i++) {
      final value = valueForIndex(i);
      final angle = (i * (360 / count) - 90) * pi / 180;

      final labelOffset = Offset(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );

      final isSelected = selectedValue == value;

      final textStyle = TextStyle(
        fontFamily: 'Google Sans',
        fontSize: isSelectingHours && radius < 70 ? 11.0 : 13.0,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        color: isSelected ? Colors.white : TectaColors.grey700,
      );

      textPainter.text = TextSpan(
        text: value.toString().padLeft(isSelectingHours ? 1 : 2, '0'),
        style: textStyle,
      );
      textPainter.layout();

      // Draw text centered at labelOffset
      canvas.save();
      canvas.translate(labelOffset.dx, labelOffset.dy);
      textPainter.paint(
        canvas,
        Offset(-textPainter.width / 2, -textPainter.height / 2),
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _DialPainter oldDelegate) {
    return oldDelegate.isSelectingHours != isSelectingHours ||
        oldDelegate.selectedValue != selectedValue ||
        oldDelegate.format != format ||
        oldDelegate.activeColor != activeColor;
  }
}
