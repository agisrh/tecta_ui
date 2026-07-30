import 'package:flutter/material.dart';
import 'package:tecta_ui/tecta_ui.dart';

/// A premium, highly customizable Month Picker widget for the Tecta Design System.
class TectaMonthPicker extends StatefulWidget {
  /// The initially selected month (1-12).
  final int? selectedMonth;

  /// Callback when a month is selected.
  final ValueChanged<int> onMonthSelected;

  /// Custom background color of the active/selected month.
  final Color? selectedColor;

  /// Text style for grid items.
  final TextStyle? gridTextStyle;

  /// Text style for selected grid item.
  final TextStyle? selectedGridTextStyle;

  /// Custom list of 12 month string representations.
  final List<String>? monthNames;

  const TectaMonthPicker({
    super.key,
    required this.selectedMonth,
    required this.onMonthSelected,
    this.selectedColor,
    this.gridTextStyle,
    this.selectedGridTextStyle,
    this.monthNames,
  });

  @override
  State<TectaMonthPicker> createState() => _TectaMonthPickerState();
}

class _TectaMonthPickerState extends State<TectaMonthPicker> {
  final List<String> _months = const [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];

  List<String> _getLocalizedMonths(BuildContext context) {
    if (widget.monthNames != null) return widget.monthNames!;

    try {
      final localizations = MaterialLocalizations.of(context);
      return List.generate(12, (index) {
        final date = DateTime(2026, index + 1, 1);
        final formatted = localizations.formatMonthYear(date);

        // Remove the year 2026 and clean up the result to extract only the month name
        String month = formatted.replaceAll('2026', '').trim();
        // Remove trailing/leading separator characters (like spaces, commas, slashes)
        month = month.replaceAll(RegExp(r'^[\s,./\-\\—–]+|[\s,./\-\\—–]+$'), '');

        if (month.isNotEmpty) {
          month = month[0].toUpperCase() + month.substring(1);
        }
        return month.isNotEmpty ? month : _months[index];
      });
    } catch (_) {
      return _months;
    }
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = widget.selectedColor ?? Theme.of(context).colorScheme.primary;
    final resolvedPrimary = TectaColors.resolve(context, primaryColor);
    final localizedMonths = _getLocalizedMonths(context);

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 360.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 2.0,
        ),
        itemCount: 12,
        itemBuilder: (context, index) {
          final monthNumber = index + 1;
          final isSelected = widget.selectedMonth == monthNumber;

          Color? bgColor = isSelected ? resolvedPrimary : Colors.transparent;
          Color borderCol = isSelected ? resolvedPrimary : TectaColors.grey200;

          final Color textColor = isSelected
              ? (resolvedPrimary.computeLuminance() > 0.5 ? TectaColors.grey900 : Colors.white)
              : TectaColors.grey800;

          final TextStyle defaultStyle = TectaTypography.body2.copyWith(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: textColor,
          );

          return Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => widget.onMonthSelected(monthNumber),
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: bgColor,
                  border: Border.all(color: borderCol, width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                alignment: Alignment.center,
                child: Text(
                  localizedMonths[index],
                  style: (isSelected ? widget.selectedGridTextStyle : widget.gridTextStyle) ?? defaultStyle,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// A premium, highly customizable Year Picker widget for the Tecta Design System.
class TectaYearPicker extends StatefulWidget {
  /// The initially selected year.
  final int? selectedYear;

  /// Callback when a year is selected.
  final ValueChanged<int> onYearSelected;

  /// Custom background color of the active/selected year.
  final Color? selectedColor;

  /// Text style for grid items.
  final TextStyle? gridTextStyle;

  /// Text style for selected grid item.
  final TextStyle? selectedGridTextStyle;

  /// The first (minimum) year. Defaults to currentYear - 50.
  final int? firstYear;

  /// The last (maximum) year. Defaults to currentYear + 50.
  final int? lastYear;

  const TectaYearPicker({
    super.key,
    required this.selectedYear,
    required this.onYearSelected,
    this.selectedColor,
    this.gridTextStyle,
    this.selectedGridTextStyle,
    this.firstYear,
    this.lastYear,
  });

  @override
  State<TectaYearPicker> createState() => _TectaYearPickerState();
}

class _TectaYearPickerState extends State<TectaYearPicker> {
  late int _startYearPage;
  final int _yearsPerPage = 12;

  late int _minYear;
  late int _maxYear;

  @override
  void initState() {
    super.initState();
    final currentYear = DateTime.now().year;
    _minYear = widget.firstYear ?? (currentYear - 50);
    _maxYear = widget.lastYear ?? (currentYear + 50);

    final initialYear = widget.selectedYear ?? currentYear;
    // Align start year of page to be a multiple of 12
    _startYearPage = initialYear - (initialYear % _yearsPerPage);
  }

  void _prevPage() {
    if (_startYearPage - _yearsPerPage >= _minYear) {
      setState(() {
        _startYearPage -= _yearsPerPage;
      });
    }
  }

  void _nextPage() {
    if (_startYearPage + _yearsPerPage <= _maxYear) {
      setState(() {
        _startYearPage += _yearsPerPage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = widget.selectedColor ?? Theme.of(context).colorScheme.primary;
    final resolvedPrimary = TectaColors.resolve(context, primaryColor);

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 360.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left),
              color: TectaColors.grey600,
              onPressed: _prevPage,
            ),
            Text(
              '$_startYearPage - ${_startYearPage + _yearsPerPage - 1}',
              style: TectaTypography.subtitle1.copyWith(
                fontWeight: FontWeight.bold,
                color: TectaColors.grey800,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.chevron_right),
              color: TectaColors.grey600,
              onPressed: _nextPage,
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 2.0,
          ),
          itemCount: _yearsPerPage,
          itemBuilder: (context, index) {
            final year = _startYearPage + index;
            final isSelected = widget.selectedYear == year;
            final isOutOfRange = year < _minYear || year > _maxYear;

            if (isOutOfRange) {
              return const SizedBox.shrink();
            }

            Color? bgColor = isSelected ? resolvedPrimary : Colors.transparent;
            Color borderCol = isSelected ? resolvedPrimary : TectaColors.grey200;

            final Color textColor = isSelected
                ? (resolvedPrimary.computeLuminance() > 0.5 ? TectaColors.grey900 : Colors.white)
                : TectaColors.grey800;

            final TextStyle defaultStyle = TectaTypography.body2.copyWith(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: textColor,
            );

            return Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => widget.onYearSelected(year),
                borderRadius: BorderRadius.circular(10.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: bgColor,
                    border: Border.all(color: borderCol, width: 1.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '$year',
                    style: (isSelected ? widget.selectedGridTextStyle : widget.gridTextStyle) ?? defaultStyle,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    ),
  );
}
}
