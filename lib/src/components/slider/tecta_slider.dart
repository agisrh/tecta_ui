import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

/// A premium, highly customizable Slider component matching Minimals design language.
///
/// Features:
/// - Styled linear track height and soft inactive track base.
/// - Circular thumb dragging control with custom ripple overlay halos.
/// - Optional indicator value tooltips.
class TectaSlider extends StatelessWidget {
  /// The current value of the slider.
  final double value;

  /// Callback triggered when value changes. If null, slider is disabled.
  final ValueChanged<double>? onChanged;

  /// Minimum value of the slider. Defaults to `0.0`.
  final double min;

  /// Maximum value of the slider. Defaults to `1.0`.
  final double max;

  /// Number of discrete division steps. If null, slider is continuous.
  final int? divisions;

  /// Text label to display inside the value indicator tooltip.
  final String? label;

  /// Custom active track and thumb color override. Defaults to [TectaColors.primaryMain].
  final Color? activeColor;

  /// Custom inactive track color override. Defaults to [TectaColors.grey200].
  final Color? inactiveColor;

  /// Creates a [TectaSlider] range/value selector slider component.
  const TectaSlider({
    super.key,
    required this.value,
    this.onChanged,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.label,
    this.activeColor,
    this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    final Color primary = activeColor ?? Theme.of(context).colorScheme.primary;
    final Color inactive = inactiveColor ?? TectaColors.grey200;

    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackHeight: 6.0,
        activeTrackColor: primary,
        inactiveTrackColor: inactive,
        thumbColor: primary,
        overlayColor: primary.withValues(alpha: 0.12),
        valueIndicatorColor: TectaColors.grey800,
        valueIndicatorTextStyle: TectaTypography.caption.copyWith(
          color: TectaColors.white,
          fontSize: 11.0,
        ),
        valueIndicatorShape: const RectangularSliderValueIndicatorShape(),
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8.0, pressedElevation: 4.0),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 18.0),
      ),
      child: Slider(
        value: value,
        min: min,
        max: max,
        divisions: divisions,
        label: label,
        onChanged: onChanged,
      ),
    );
  }
}
